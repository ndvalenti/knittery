//
//  QueryBuilder.swift
//  Knittery
//
//  Created by Nick on 2022-10-12.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

struct Query {
    let sort: QSort?
    let invert: Bool?
    let page: String?
    let notebook: [QNotebook]?
    let craft: [QCraft]?
    let availability: [QAvailability]?
    let weight: [QWeight]?
    
    init (
        sort: QSort? = QSort.best,
        invert: Bool? = nil,
        page: String? = nil,
        notebook: [QNotebook]? = [],
        craft: [QCraft]? = [],
        availability: [QAvailability]? = [],
        weight: [QWeight]? = []
    ) {
        self.sort = sort
        self.invert = invert
        self.page = page
        self.notebook = notebook
        self.craft = craft
        self.availability = availability
        self.weight = weight
    }
}

// Separator %7C
// Cat Separator $
// URL/Query Separator #
// Exclude -
// Invert _

class QueryBuilder {
    static private let startSymbol = "?"
    static private let separator = "%7C"
    static private let catQuery = "$"
    static private let invertSymbol = "_"
    
    let query: Query
    
    init(query: Query) {
        self.query = query
    }
    
    static func build(_ query: Query) -> String? {
        var valid: Bool = false
        var result = startSymbol
        
        if let sort = query.sort {
            valid = true
            result += "sort="
            if query.invert == true {
                result += invertSymbol
            }
            result += sort.rawValue
        }
        
        if let page = query.page {
            if valid { result += catQuery } else { valid = true }
            result += "page=" + page
        }
        
        if let craft = query.craft {
            if !craft.isEmpty {
                if valid { result += catQuery } else { valid = true }
                result += craft.map {
                    $0.rawValue
                }
                .joined(separator: separator)
            }
        }
        
        if let notebook = query.notebook {
            if !notebook.isEmpty {
                if valid { result += catQuery } else { valid = true }
                result += notebook.map {
                    $0.rawValue
                }
                .joined(separator: separator)
            }
        }
        
        if let availability = query.availability {
            if !availability.isEmpty {
                if valid { result += catQuery } else { valid = true }
                result += availability.map {
                    $0.rawValue
                }
                .joined(separator: separator)
            }
        }
        
        if let weight = query.weight {
            if !weight.isEmpty {
                if valid { result += catQuery } else { valid = true }
                result += weight.map {
                    $0.rawValue
                }
                .joined(separator: separator)
            }
        }
        
        if valid {
            return result
        }
        
        return nil
    }
}
