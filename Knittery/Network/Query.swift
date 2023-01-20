//
//  Query.swift
//  Knittery
//
//  Created by Nick on 2022-12-17.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

class Query: ObservableObject {
    var search: String
    var sort: QSort
    var invert: Bool
    var requireImages: Bool
    var page: String?
    var pageSize: String?
    var category: String?
    var notebook: [QNotebook : Bool]
    var craft: [QCraft : Bool]
    var availability: [QAvailability : Bool]
    var weight: [QWeight : Bool]
    
    // There are a lot of search parameters that don't fit nicely in to a box and require
    // complex user input such as searching by country, website etc
    
    // Append allows a query to be modified with hard-coded strings,
    // needs to be tightly controlled though most queries will still work

    // If necessary this variable can become an array of additional hard-coded queries but
    // I'd like to avoid that if possible for obvious reasons
    var append: String?
    
    var searchTitle: String? {
        if search.isEmpty {
            // TODO: This can be reworked to be much more informative about what was searched and why
            return "Displaying search results:"
        } else {
            return "Search results for \"\(self.search)\":"
        }
    }
    
    // TODO: Determine sorting behavior if sort argument is not supplied and adjust if necessary
    init(
        search: String = "",
        sort: QSort = QSort.best,
        invert: Bool = false,
        requireImages: Bool = false,
        page: String? = nil,
        pageSize: String? = nil,
        append: String? = nil,
        category: String? = nil,
        notebook: [QNotebook] = [],
        craft: [QCraft] = [],
        availability: [QAvailability] = [],
        weight: [QWeight] = []
    ) {
        self.search = search
        self.sort = sort
        self.invert = invert
        self.requireImages = requireImages
        self.page = page
        self.pageSize = pageSize
        self.append = append
        self.category = category
        self.notebook = .init()
        self.craft = .init()
        self.availability = .init()
        self.weight = .init()
        
        QNotebook.allCases.forEach { self.notebook[$0] = notebook.contains($0) }
        QCraft.allCases.forEach { self.craft[$0] = craft.contains($0) }
        QAvailability.allCases.forEach { self.availability[$0] = availability.contains($0) }
        QWeight.allCases.forEach { self.weight[$0] = weight.contains($0) }
    }
    
    /// Set search option key.rawValue in category to setValue for this query
    /// Returns the value that was set or nil if operation fails
    func updateSearchParameter(searchOptionCategory: SearchOptionCategory?, key: String?, setValue: Bool?) -> Bool? {
        guard let searchOptionCategory, let key, let setValue else { return nil }
        
        switch searchOptionCategory {
        case .notebook:
            guard let targetKey = QNotebook(rawValue: key) else { return nil }
            notebook[targetKey] = setValue
        case .craft:
            guard let targetKey = QCraft(rawValue: key) else { return nil }
            craft[targetKey] = setValue
        case .availability:
            guard let targetKey = QAvailability(rawValue: key) else { return nil }
            availability[targetKey] = setValue
        case .weight:
            guard let targetKey = QWeight(rawValue: key) else { return nil }
            weight[targetKey] = setValue
        default:
            // For sort or other categories that don't rely on dict
            return nil
        }
        return setValue
    }
    
    func clear() {
        search = ""
        sort = QSort.best
        invert = false
        requireImages = true
        page = nil
        pageSize = nil
        append = nil
        category = nil
        notebook.keys.forEach { notebook[$0] = false }
        craft.keys.forEach { craft[$0] = false }
        availability.keys.forEach { availability[$0] = false }
        weight.keys.forEach { weight[$0] = false }
    }
}

extension Query {
    convenience init(patternCategory: PatternCategory, sort: QSort = QSort.best, requireImages: Bool = true, pageSize: String? = nil) {
        self.init(sort: sort, requireImages: requireImages, pageSize: pageSize)
        category = patternCategory.permalink
    }
}
