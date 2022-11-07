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
    var notebook: [QNotebook]
    var craft: [QCraft]
    var availability: [QAvailability]
    var weight: [QWeight]
    
    // TODO: Determine sorting behavior if sort argument is not supplied and adjust if necessary
    init (
        search: String = "",
        sort: QSort = QSort.best,
        invert: Bool = false,
        page: String? = nil,
        notebook: [QNotebook] = [],
        craft: [QCraft] = [],
        availability: [QAvailability] = [],
        weight: [QWeight] = []
    ) {
        self.search = search
        self.sort = sort
        self.invert = invert
        self.page = page
        self.notebook = notebook
        self.craft = craft
        self.availability = availability
        self.weight = weight
    }
    
    func clear() {
        search = ""
        sort = QSort.best
        invert = false
        page = nil
        notebook.removeAll()
        craft.removeAll()
        availability.removeAll()
        weight.removeAll()
    }
}

class QueryBuilder {
    static private let startSymbol = "?"
    static private let separator = "%7C"
    static private let concat = "$"
    static private let invertSymbol = "_"
    
    static func build(_ query: Query) -> String? {
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
        
        if !query.craft.isEmpty {
            result += QueryBuilder.concat + "craft=" + query.craft.map {
                $0.rawValue
            }
            .joined(separator: QueryBuilder.separator)
        }
        
        if !query.notebook.isEmpty {
            result += QueryBuilder.concat + "notebook-p=" + query.notebook.map {
                $0.rawValue
            }
            .joined(separator: QueryBuilder.separator)
        }
        
        if !query.availability.isEmpty {
            result += QueryBuilder.concat + "availability=" + query.availability.map {
                $0.rawValue
            }
            .joined(separator: QueryBuilder.separator)
        }
        
        if !query.weight.isEmpty {
            result += QueryBuilder.concat + "weight=" + query.weight.map {
                $0.rawValue
            }
            .joined(separator: QueryBuilder.separator)
        }
        
        return result
    }
}
