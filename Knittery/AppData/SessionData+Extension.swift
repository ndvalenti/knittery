//
//  SessionData+Extension.swift
//  Knittery
//
//  Created by Nick on 2022-12-14.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

extension SessionData {
    func signOut() {
        signOutDelegate?.signOut()
    }
    
    func clearData() {
        currentUser = nil
        invalidateAllDefaultQueries()
    }
    
    func populateQueries() {
        DefaultContent.allCases.forEach { defaultQuery in
            if defaultQueries[defaultQuery] == nil {
                populateDefaultQuery(defaultQuery)
            }
        }
    }
    
    ///  Randomly store a category from a random result from a supplied DefaultContent query in relatedCategory
    func tryPopulateRelatedCategoryFrom(_ query: DefaultContent) {
        if let query = defaultQueries[query] {
            if let randomItem = query.randomElement(), let resultID = randomItem.id {
                NetworkHandler.requestPatternById(resultID) { [weak self] (result: Result<Pattern, ApiError>) in
                    switch result {
                    case .success(let pattern):
                        DispatchQueue.main.async {
                            if let related = pattern.patternCategories?.randomElement()?.flatChildren?.randomElement(),
                               let name = randomItem.name {
                                self?.tryPopulateRelatedResults(trigger: name, category: related)
                            }
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
    
    /// Attempt to populate relatedCategoryResults and associated related* values
    func tryPopulateRelatedResults(trigger: String, category: PatternCategory) {
        let query = Query(patternCategory: category, pageSize: "15")
        let queryString = QueryBuilder.build(query)
        
        NetworkHandler.requestPatternSearch(query: queryString) { [weak self] (result: Result<PatternSearch, ApiError>) in
            switch result {
            case .success(let search):
                DispatchQueue.main.async {
                    self?.relatedCategory = category
                    self?.relatedCategoryTrigger = trigger
                    self?.relatedCategoryQuery = query
                    self?.relatedCategoryResults = search.patterns
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setSessionDisplayCategory() {
        while sampleCategory == nil {
            let id = PatternCategory.defaultIDList.randomElement()
            sampleCategory = allCategories?.flatChildren?.first { $0.id == id }
        }
        
        guard let sampleCategory else { return }
        
        if currentUser != nil {
            sampleCategoryQuery = Query(patternCategory: sampleCategory, pageSize: "15")
            
            guard let sampleCategoryQuery else { return }
            
            let query = QueryBuilder.build(sampleCategoryQuery)
            NetworkHandler.requestPatternSearch(query: query) { [weak self] (result: Result<PatternSearch, ApiError>) in
                switch result {
                case .success (let search):
                    DispatchQueue.main.async {
                        self?.sampleCategoryResults = search.patterns
                    }
                case .failure:
                    DispatchQueue.main.async {
                        self?.sampleCategoryResults = nil
                    }
                }
                
            }
        }
    }
    
    func populateCategories() {
        if let lastCategoryFetch {
            if Date().timeIntervalSince(lastCategoryFetch) < 86400 {
                if let data = UserDefaults.standard.object(forKey: "categoriesCache") as? Data,
                   let categories = try? JSONDecoder().decode(PatternCategory.self, from: data) {
                    self.allCategories = categories
                    self.setSessionDisplayCategory()
                    return
                }
            }
        }
        
        if currentUser != nil {
            NetworkHandler.requestCategories() { [weak self] (result: Result<PatternCategories, ApiError>) in
                switch result {
                case .success (let categories):
                    if let categories = categories.rootCategory
                    {
                        DispatchQueue.main.async {
                            self?.allCategories = categories
                            self?.setSessionDisplayCategory()
                            UserDefaults.standard.set(Date(), forKey: "categoriesFetched")
                            if let encoded = try? JSONEncoder().encode(categories) {
                                UserDefaults.standard.set(encoded, forKey: "categoriesCache")
                            }
                        }
                    }
                case .failure (let error):
                    print(error)
                }
            }
        }
    }
    
    func populateDefaultQuery(_ defaultQuery: DefaultContent) {
        if currentUser != nil, let query = defaultQuery.query {
            NetworkHandler.requestPatternSearch(query: QueryBuilder.build(query)) { [weak self] (result: Result<PatternSearch, ApiError>) in
                switch result {
                case .success (let search):
                    DispatchQueue.main.async {
                        self?.defaultQueries[defaultQuery] = search.patterns
                        if defaultQuery == .favoritePatterns, self?.relatedCategory == nil {
                            self?.tryPopulateRelatedCategoryFrom(.favoritePatterns)
                        }
                    }
                case .failure:
                    DispatchQueue.main.async {
                        self?.defaultQueries[defaultQuery] = nil
                    }
                }
            }
        }
    }
    
    func invalidateDefaultQuery(_ query: DefaultContent) {
        defaultQueries[query] = nil
    }
    
    private func invalidateAllDefaultQueries() {
        DefaultContent.allCases.forEach { query in
            invalidateDefaultQuery(query)
        }
    }
    
    func checkEmptyDefaultContent(defaults: [DefaultContent]) -> Bool {
        var stale = true
        defaults.forEach { d in
            if defaultQueries[d]?.isEmpty == false {
                stale = false
            }
        }
        return stale
    }
}
