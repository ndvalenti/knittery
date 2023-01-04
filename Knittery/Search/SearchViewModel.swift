//
//  SearchViewModel.swift
//  Knittery
//
//  Created by Nick on 2022-11-02.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation
import Combine

class SearchCategory: Identifiable, ObservableObject {
    let id = UUID()
    let categoryTitle: String
    let categoryRaw: String?
    let category: SearchOptionCategory?
    var isChecked: Bool?
    var items: [SearchCategory]?
    /// if set to onChange() this function acts ss a hook that can be used by children to trigger updates in their parents
    var didChange: (() -> Void)?
    
    @Published private(set) var itemSubstring: String = ""
    
    init(categoryTitle: String, categoryRaw: String? = nil, category: SearchOptionCategory? = nil, isChecked: Bool? = nil) {
        self.categoryTitle = categoryTitle
        self.categoryRaw = categoryRaw
        self.category = category
        self.isChecked = isChecked
    }
    
    /// set isChecked to a value from source of truth and call didChange() hook
    func set(_ isChecked: Bool?) {
        self.isChecked = isChecked
        
        didChange?()
    }
    
    /// populate itemSubstring with a comma delineated list of this object's SearchCategory children that have a true isChecked value
    func onChange() {
        guard let items else { return }
        itemSubstring = items.filter{ $0.isChecked == true }.map{ $0.categoryTitle }.joined(separator: ", ")
    }
}

class SearchViewModel: ObservableObject {
    @Published var query: Query
    @Published private var queryString: String
    @Published private(set) var searchCategories = [SearchCategory]()
    
    private var subscriptions: Set<AnyCancellable> = []
    
    enum NavDestination: Hashable {
        case result
    }
    
    init() {
        query = .init()
        queryString = .init()
        resetQuery()
    }
    
    func buildQuery() {
        queryString = QueryBuilder.build(query)
    }
    
    func resetQuery() {
        query.clear()
        populateSearchCategory(.notebook)
        populateSearchCategory(.craft)
        populateSearchCategory(.availability)
        populateSearchCategory(.weight)
    }

    private func populateSearchCategory(_ searchOptionCategory: SearchOptionCategory) {
        switch searchOptionCategory {
        case .notebook: populateSearchCategory_internal(searchOptionCategory, queryType: query.notebook)
        case .craft: populateSearchCategory_internal(searchOptionCategory, queryType: query.craft)
        case .availability: populateSearchCategory_internal(searchOptionCategory, queryType: query.availability)
        case .weight: populateSearchCategory_internal(searchOptionCategory, queryType: query.weight)
        default:
            return
        }
    }
    
    /// WARNING: This function is for internal use only, use populateSearchCategory(_ searchOptionCategory:) instead
    private func populateSearchCategory_internal(_ searchOptionCategory: SearchOptionCategory, queryType: [some SearchOption: Bool]) {
        searchCategories.removeAll(where: { $0.categoryTitle == searchOptionCategory.display } )
        
        let patternCategory = SearchCategory(categoryTitle: searchOptionCategory.display)
        var childArray = [SearchCategory]()
        
        queryType.forEach { option in
            if let name = option.key.displayName {
                let currentOption = SearchCategory(
                    categoryTitle: name,
                    categoryRaw: option.key.rawValue as? String,
                    category: searchOptionCategory,
                    isChecked: option.value
                )
                currentOption.didChange = patternCategory.onChange
                childArray.append(currentOption)
            }
        }
        patternCategory.items = childArray.sorted { $0.categoryTitle < $1.categoryTitle }
        patternCategory.objectWillChange.sink(receiveValue: { _ in
            self.objectWillChange.send()
        }).store(in: &self.subscriptions)
        searchCategories.append(patternCategory)
    }
}
