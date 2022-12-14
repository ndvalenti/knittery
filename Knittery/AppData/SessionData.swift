//
//  SessionData.swift
//  Knittery
//
//  Created by Nicholas Valenti on 2022-09-23.
//

import Foundation
import UIKit

class SessionData: ObservableObject {
    @Published var defaultQueries = [DefaultContent: [PatternResult]]()
    var lastCategoryFetch: Date?
    
    // These categories almost never change and when they do it's generally just display names
    // we try to cache them for 24 hours and will display some defaults that we can rely on to exist
    var categories: PatternCategory?
    var sessionDisplayCategory: PatternCategory?
    
    weak var signOutDelegate: SignOutDelegate?
    
    init() {
        lastCategoryFetch = UserDefaults.standard.object(forKey: "categoriesFetched") as? Date
    }
    
    @Published var currentUser: User? { didSet {
        guard let currentUser, let photoURL = currentUser.photoURL else {
            profilePicture = nil
            return
        }
        
        NetworkHandler.loadImageFrom(url: photoURL) { image in
            self.profilePicture = image
        }
    } }
    
    @Published var profilePicture: UIImage? = nil
    
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
        while sessionDisplayCategory == nil {
            var id = PatternCategory.defaultIDList.randomElement()
            sessionDisplayCategory = categories?.flatChildren?.first { $0.id == id }
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
                        self?.categories = categories
                        self?.setSessionDisplayCategory()
                        UserDefaults.standard.set(Date(), forKey: "categoriesFetched")
                        if let encoded = try? JSONEncoder().encode(categories) {
                            UserDefaults.standard.set(encoded, forKey: "categoriesCache")
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
            NetworkHandler.requestPatternSearch(query: query) { [weak self] (result: Result<PatternSearch, ApiError>) in
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
    
    func checkEmptyDefaultContent (defaults: [DefaultContent]) -> Bool {
        var stale = true
        defaults.forEach { d in
            if defaultQueries[d]?.isEmpty == false {
                stale = false
            }
        }
        return stale
    }
}


