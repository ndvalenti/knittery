//
//  SessionData.swift
//  Knittery
//
//  Created by Nicholas Valenti on 2022-09-23.
//

import Foundation
import UIKit

class SessionData: ObservableObject {
    @Published var defaultQueries = [DefaultQuery: [PatternResult]]()
    var lastCategoryFetch: Date?
    var categories: PatternCategory?
    
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
    
    func populateQueries() {
        DefaultQuery.allCases.forEach { defaultQuery in
            populateDefaultQuery(defaultQuery)
        }
    }
    
    func populateCategories() {
        if let lastCategoryFetch {
            if Date().timeIntervalSince(lastCategoryFetch) < 86400 {
                if let data = UserDefaults.standard.object(forKey: "categoriesCache") as? Data,
                   let categories = try? JSONDecoder().decode(PatternCategory.self, from: data) {
                    self.categories = categories
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
    
    func populateDefaultQuery(_ defaultQuery: DefaultQuery) {
        if currentUser != nil {
            NetworkHandler.requestPatternSearch(query: defaultQuery.query) { [weak self] (result: Result<PatternSearch, ApiError>) in
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
    
    func invalidateDefaultQuery(_ query: DefaultQuery) {
        defaultQueries[query] = nil
    }
    
    private func invalidateAllDefaultQueries() {
        DefaultQuery.allCases.forEach { query in
            invalidateDefaultQuery(query)
        }
    }
    
    func signOut() {
        signOutDelegate?.signOut()
    }
    
    func clearData() {
        currentUser = nil
        invalidateAllDefaultQueries()
    }
}


