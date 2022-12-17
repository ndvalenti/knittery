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
    
    func setSessionDisplayCategory() {
        while sampleCategory == nil {
            let id = PatternCategory.defaultIDList.randomElement()
            sampleCategory = categories?.flatChildren?.first { $0.id == id }
        }
        
        guard let sampleCategory else { return }
        
        if currentUser != nil {
            sampleQuery = Query(patternCategory: sampleCategory, pageSize: "15")
            
            guard let sampleQuery else { return }
            
            let query = QueryBuilder.build(sampleQuery)
            NetworkHandler.requestPatternSearch(query: query) { [weak self] (result: Result<PatternSearch, ApiError>) in
                switch result {
                case .success (let search):
                    DispatchQueue.main.sync {
                        self?.sampleCategoryResults = search.patterns
                    }
                case .failure:
                    DispatchQueue.main.sync {
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
                    self.categories = categories
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
                        DispatchQueue.main.sync {
                            self?.categories = categories
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
                    DispatchQueue.main.sync {
                        self?.defaultQueries[defaultQuery] = search.patterns
                    }
                case .failure:
                    DispatchQueue.main.sync {
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
