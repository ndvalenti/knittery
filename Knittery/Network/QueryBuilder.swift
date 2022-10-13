//
//  QueryBuilder.swift
//  Knittery
//
//  Created by Nick on 2022-10-12.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

class Query {
    let search: String?
    let sort: QSort?
    let invert: Bool?
    let page: String?
    let notebook: [QNotebook]?
    let craft: [QCraft]?
    let availability: [QAvailability]?
    let weight: [QWeight]?
    
    init (
        search: String? = "",
        sort: QSort? = QSort.best,
        invert: Bool? = nil,
        page: String? = nil,
        notebook: [QNotebook]? = [],
        craft: [QCraft]? = [],
        availability: [QAvailability]? = [],
        weight: [QWeight]? = []
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
}

class QueryBuilder {
    static private let startSymbol = "?"
    static private let separator = "%7C"
    static private let catQuery = "$"
    static private let invertSymbol = "_"
    
    let query: Query
    
    init(query: Query) {
        self.query = query
    }
    
    func build() -> String? {
        var valid: Bool = false
        var result = QueryBuilder.startSymbol
        
        if let search = query.search {
            valid = true
            result += "query=" + search
        } else {
            // TODO: need tests to ensure that blank queries function similarily to the website, otherwise this needs to be less permissive
            return nil
        }
        
        if let sort = query.sort {
            result += QueryBuilder.catQuery + "sort="
            if query.invert == true {
                result += QueryBuilder.invertSymbol
            }
            result += sort.rawValue
        }
        
        if let page = query.page {
            result += QueryBuilder.catQuery + "page=" + page
        }
        
        if let craft = query.craft {
            if !craft.isEmpty {
                result += QueryBuilder.catQuery + craft.map {
                    $0.rawValue
                }
                .joined(separator: QueryBuilder.separator)
            }
        }
        
        if let notebook = query.notebook {
            if !notebook.isEmpty {
                result += QueryBuilder.catQuery + notebook.map {
                    $0.rawValue
                }
                .joined(separator: QueryBuilder.separator)
            }
        }
        
        if let availability = query.availability {
            if !availability.isEmpty {
                result += QueryBuilder.catQuery + availability.map {
                    $0.rawValue
                }
                .joined(separator: QueryBuilder.separator)
            }
        }
        
        if let weight = query.weight {
            if !weight.isEmpty {
                result += QueryBuilder.catQuery + weight.map {
                    $0.rawValue
                }
                .joined(separator: QueryBuilder.separator)
            }
        }
        
        if valid {
            return result
        }
        return nil
    }
}
