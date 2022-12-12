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
        populateSearchCategories()
    }
    
    func buildQuery() {
        queryString = QueryBuilder.build(query)
    }
    
    func resetQuery() {
        query.clear()
        populateSearchCategories()
    }
    
    // TODO: This is an ugly function that needs refactoring but requires some sort of struct layer to pass the relevant information from our query pairs
    /// Fill searchCategories with information necessary to build a nested list and connect it to this object's query object
    /// Query remains single source of truth with SearchCategories containing necessary information and signals and slots to properly update it
    private func populateSearchCategories() {
        searchCategories.removeAll()
        let patternCategory = SearchCategory(categoryTitle: QNotebook.categoryName)
        var childArray = [SearchCategory]()
        
        query.notebook.forEach { option in
            if let name = option.key.displayName {
                let currentOption = SearchCategory (
                    categoryTitle: name,
                    categoryRaw: option.key.rawValue,
                    category: SearchOptionCategory.notebook,
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
        
        let craftCategory = SearchCategory(categoryTitle: QCraft.categoryName)
        childArray.removeAll()
        query.craft.forEach { option in
            if let name = option.key.displayName {
                let currentOption = SearchCategory (
                    categoryTitle: name,
                    categoryRaw: option.key.rawValue,
                    category: SearchOptionCategory.craft,
                    isChecked: option.value
                )
                currentOption.didChange = craftCategory.onChange
                childArray.append(currentOption)
            }
        }
        craftCategory.items = childArray.sorted { $0.categoryTitle < $1.categoryTitle }
        craftCategory.objectWillChange.sink(receiveValue: { _ in
            self.objectWillChange.send()
        }).store(in: &self.subscriptions)
        searchCategories.append(craftCategory)
        
        let availabilityCategory = SearchCategory(categoryTitle: QAvailability.categoryName)
        childArray.removeAll()
        query.availability.forEach { option in
            if let name = option.key.displayName {
                let currentOption = SearchCategory (
                    categoryTitle: name,
                    categoryRaw: option.key.rawValue,
                    category: SearchOptionCategory.availability,
                    isChecked: option.value
                )
                currentOption.didChange = availabilityCategory.onChange
                childArray.append(currentOption)
            }
        }
        availabilityCategory.items = childArray.sorted { $0.categoryTitle < $1.categoryTitle }
        availabilityCategory.objectWillChange.sink(receiveValue: { _ in
            self.objectWillChange.send()
        }).store(in: &self.subscriptions)
        searchCategories.append(availabilityCategory)
        
        let weightCategory = SearchCategory(categoryTitle: QWeight.categoryName)
        childArray.removeAll()
        query.weight.forEach { option in
            if let name = option.key.displayName {
                let currentOption = SearchCategory (
                    categoryTitle: name,
                    categoryRaw: option.key.rawValue,
                    category: SearchOptionCategory.weight,
                    isChecked: option.value
                )
                currentOption.didChange = weightCategory.onChange
                childArray.append(currentOption)
            }
        }
        weightCategory.items = childArray.sorted { $0.categoryTitle < $1.categoryTitle }
        weightCategory.objectWillChange.sink(receiveValue: { _ in
            self.objectWillChange.send()
        }).store(in: &self.subscriptions)
        searchCategories.append(weightCategory)
    }
}
