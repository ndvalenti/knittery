//
//  QueryBuilder.swift
//  Knittery
//
//  Created by Nick on 2022-10-12.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

//TODO: Add number of results
class Query: ObservableObject {
    var search: String
    var sort: QSort
    var invert: Bool
    var requireImages: Bool
    var page: String?
    var pageSize: String?
    var notebook: [QNotebook : Bool]
    var craft: [QCraft : Bool]
    var availability: [QAvailability : Bool]
    var weight: [QWeight : Bool]
    
    // There are a lot of search parameters that don't fit nicely in to a box and require
    // complex user input such as searching by country, website etc
    //
    // Append allows a query to be modified with hard-coded strings,
    // not ideal and needs to be tightly controlled though most queries will still work
    //
    // If necessary this variable can become an array of additional hard-coded queries but
    // I'd like to avoid that if possible for obvious reasons
    var append: String?
    
    // TODO: Determine sorting behavior if sort argument is not supplied and adjust if necessary
    init(
        search: String = "",
        sort: QSort = QSort.best,
        invert: Bool = false,
        requireImages: Bool = false,
        page: String? = nil,
        pageSize: String? = nil,
        append: String? = nil,
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
    func updateSearchParameter(category: SearchOptionCategory?, key: String?, setValue: Bool?) -> Bool? {
        guard let category, let key, let setValue else { return nil }
        
        switch category {
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
        append = nil
        notebook.keys.forEach { notebook[$0] = false }
        craft.keys.forEach { craft[$0] = false }
        availability.keys.forEach { availability[$0] = false }
        weight.keys.forEach { weight[$0] = false }
    }
}

class QueryBuilder {
    static private let startSymbol = "?"
    static private let separator = "%7C"
    static private let space = "%20"
    static private let concat = "&"
    static private let invertSymbol = "_"
    
    static func build(_ query: Query) -> String {
        var resultBuilder: String
        var result = QueryBuilder.startSymbol
        
        // TODO: Determine behavior when query not supplied and adjust permissiveness of query
        result += "query=" + query.search.replacingOccurrences(of: " ", with: "%20")
        
        result += QueryBuilder.concat + "sort="
        if query.invert {
            result += QueryBuilder.invertSymbol
        }
        result += query.sort.rawValue
        
        if let page = query.page, let _ = Int(page) {
            result += QueryBuilder.concat + "page=" + page
        }
        
        if let pageSize = query.pageSize, let _ = Int(pageSize) {
            result += QueryBuilder.concat + "page_size=" + pageSize
        }
        
        if query.requireImages {
            result += QueryBuilder.concat + "photo=yes"
        }
        
        resultBuilder = ""
        for notebook in query.notebook {
            if notebook.value {
                if resultBuilder == "" {
                    resultBuilder += QueryBuilder.concat + "notebook-p="
                } else {
                    resultBuilder += QueryBuilder.separator
                }
                resultBuilder += notebook.key.rawValue
            }
        }
        result += resultBuilder
        
        resultBuilder = ""
        for craft in query.craft {
            if craft.value {
                if resultBuilder == "" {
                    resultBuilder += QueryBuilder.concat + "craft="
                } else {
                    resultBuilder += QueryBuilder.separator
                }
                resultBuilder += craft.key.rawValue
            }
        }
        result += resultBuilder
        
        resultBuilder = ""
        for availability in query.availability {
            if availability.value {
                if resultBuilder == "" {
                    resultBuilder += QueryBuilder.concat + "availability="
                } else {
                    resultBuilder += QueryBuilder.separator
                }
                resultBuilder += availability.key.rawValue
            }
        }
        result += resultBuilder
        
        resultBuilder = ""
        for weight in query.weight {
            if weight.value {
                if resultBuilder == "" {
                    resultBuilder += QueryBuilder.concat + "weight="
                } else {
                    resultBuilder += QueryBuilder.separator
                }
                resultBuilder += weight.key.rawValue
            }
        }
        result += resultBuilder
        
        if let append = query.append {
            result += QueryBuilder.concat + append
        }
        
        return result
    }
}
