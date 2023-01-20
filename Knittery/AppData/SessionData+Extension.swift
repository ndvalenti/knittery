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
        allCategories = nil
        lastCategoryFetch = nil
        libraryItems = nil
        //        relatedItems = nil
        //        randomItems = nil
        sampleCategory = nil
        sampleCategoryQuery = nil
        sampleCategoryResults = nil
        relatedCategory = nil
        relatedCategoryQuery = nil
        relatedCategoryResults = nil
        relatedCategoryTrigger = nil
    }
    
    func setUpDefaults() {
        populateQueries()
        populateCategories()
        populateLibraryItems()
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
        guard
            let query = defaultQueries[query],
            let randomItem = query.randomElement(),
            let resultID = randomItem.id
        else {
            return
        }

        NetworkHandler.requestPatternById(resultID)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching patterns search: \(error)")
                default: return
                }
            }, receiveValue: { [weak self] pattern in
                if let related = pattern.patternCategories?.randomElement()?.flatChildren?.randomElement(),
                   let name = randomItem.name {
                    self?.tryPopulateRelatedResults(trigger: name, category: related)
                }
            })
            .store(in: &cancellables)
    }
    
    /// Attempt to populate relatedCategoryResults and associated related* values
    func tryPopulateRelatedResults(trigger: String, category: PatternCategory) {
        let query = Query(patternCategory: category, sort: .randomize, pageSize: "15")
        let queryString = QueryBuilder.build(query)

        NetworkHandler.requestPatternSearch(query: queryString)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching patterns search: \(error)")
                default: return
                }
            }, receiveValue: { [weak self] search in
                //              self?.relatedItems = SampleCategory(category: category, query: query, results: search.patterns, trigger: trigger)
                self?.relatedCategory = category
                self?.relatedCategoryTrigger = trigger
                self?.relatedCategoryQuery = query
                self?.relatedCategoryResults = search.patterns
            })
            .store(in: &cancellables)
    }
    
    func setSessionDisplayCategory() {
        while sampleCategory == nil {
            let id = PatternCategory.defaultIDList.randomElement()
            sampleCategory = allCategories?.flatChildren?.first { $0.id == id }
        }
        
        guard let sampleCategory, currentUser != nil else { return }
        
        sampleCategoryQuery = Query(patternCategory: sampleCategory, sort: .randomize, pageSize: "15")

        guard let sampleCategoryQuery else { return }

        let query = QueryBuilder.build(sampleCategoryQuery)

        NetworkHandler.requestPatternSearch(query: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching patterns search: \(error)")
                    self?.sampleCategoryResults = nil
                default: return
                }
            }, receiveValue: { [weak self] search in
                self?.sampleCategoryResults = search.patterns
            })
            .store(in: &cancellables)
    }
    
    func populateLibraryItems() {
        guard let user = currentUser?.username else { return }
        NetworkHandler.requestLibraryVolumeList(username: user)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching library items: \(error)")
                default: return
                }
            }, receiveValue: { [weak self] list in
                self?.libraryItems = list
            })
            .store(in: &cancellables)
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
            NetworkHandler.requestCategories()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print("Error fetching categories: \(error)")
                    default: return
                    }
                }, receiveValue: { [weak self] categories in
                    if let categories = categories.rootCategory {
                        self?.allCategories = categories
                        self?.setSessionDisplayCategory()
                        UserDefaults.standard.set(Date(), forKey: "categoriesFetched")
                        if let encoded = try? JSONEncoder().encode(categories) {
                            UserDefaults.standard.set(encoded, forKey: "categoriesCache")
                        }
                    }
                })
                .store(in: &cancellables)
        }
    }
    
    func populateDefaultQuery(_ defaultQuery: DefaultContent) {
        guard currentUser != nil, let query = defaultQuery.query else { return }
        NetworkHandler.requestPatternSearch(query: QueryBuilder.build(query))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching patterns search: \(error)")
                    self?.defaultQueries[defaultQuery] = nil
                default: return
                }
            }, receiveValue: { [weak self] search in
                self?.defaultQueries[defaultQuery] = search.patterns
                if defaultQuery == .favoritePatterns, self?.relatedCategory == nil {
                    self?.tryPopulateRelatedCategoryFrom(.favoritePatterns)
                }
            })
            .store(in: &cancellables)
    }
    
    func invalidateDefaultQuery(_ query: DefaultContent) {
        defaultQueries[query] = nil
    }
    
    private func invalidateAllDefaultQueries() {
        DefaultContent.allCases.forEach { query in
            invalidateDefaultQuery(query)
        }
    }
    
    func checkEmptyDefaultContent(defaults: [DefaultContent]) {
        defaults.forEach { d in
            if defaultQueries[d]?.isEmpty == true {
                populateDefaultQuery(d)
            }
        }
    }
}
