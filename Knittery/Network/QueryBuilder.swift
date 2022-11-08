//
//  QueryBuilder.swift
//  Knittery
//
//  Created by Nick on 2022-10-12.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

class Query: ObservableObject {
    var search: String
    var sort: QSort
    var invert: Bool
    var page: String?
    var notebook: [QNotebook : Bool]
    var craft: [QCraft : Bool]
    var availability: [QAvailability : Bool]
    var weight: [QWeight : Bool]
    
    // TODO: Determine sorting behavior if sort argument is not supplied and adjust if necessary
    init (
        search: String = "",
        sort: QSort = QSort.best,
        invert: Bool = false,
        page: String? = nil
    ) {
        self.search = search
        self.sort = sort
        self.invert = invert
        self.page = page
        self.notebook = .init()
        self.craft = .init()
        self.availability = .init()
        self.weight = .init()
        
        QNotebook.allCases.forEach { self.notebook[$0] = false }
        QCraft.allCases.forEach { self.craft[$0] = false }
        QAvailability.allCases.forEach { self.availability[$0] = false }
        QWeight.allCases.forEach { self.weight[$0] = false }
    }
    
    func clear() {
        search = ""
        sort = QSort.best
        invert = false
        page = nil
        notebook.keys.forEach { notebook[$0] = false }
        craft.keys.forEach { craft[$0] = false }
        availability.keys.forEach { availability[$0] = false }
        weight.keys.forEach { weight[$0] = false }
    }
}

class QueryBuilder {
    static private let startSymbol = "?"
    static private let separator = "%7C"
    static private let concat = "$"
    static private let invertSymbol = "_"
    
    static func build(_ query: Query) -> String {
        var resultBuilder: String
        var result = QueryBuilder.startSymbol
        
        // TODO: Determine behavior when query not supplied and adjust permissiveness of query
        result += "query=" + query.search
        
        result += QueryBuilder.concat + "sort="
        if query.invert {
            result += QueryBuilder.invertSymbol
        }
        result += query.sort.rawValue
        
        if let page = query.page {
            result += QueryBuilder.concat + "page=" + page
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
        
        return result
    }
}
