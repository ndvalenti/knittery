//
//  QueryBuilder.swift
//  Knittery
//
//  Created by Nick on 2022-10-12.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

class Query {
    var search: String
    var sort: QSort?
    var invert: Bool?
    var page: String?
    var notebook: [QNotebook]
    var craft: [QCraft]
    var availability: [QAvailability]
    var weight: [QWeight]
    
    init (
        search: String = "",
        sort: QSort? = QSort.best,
        invert: Bool? = nil,
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
        invert = nil
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
    static private let catQuery = "$"
    static private let invertSymbol = "_"
    
    static func build(_ query: Query) -> String? {
        //        var valid: Bool = false
        var result = QueryBuilder.startSymbol
        
        //        if let search = query.search {
        //            valid = true
        result += "query=" + query.search
        //        } else {
        //            print(QueryError.invalidQuery.description)
        // TODO: this is a really good time to implement tests, need to ensure that blank queries function the same as on the website, otherwise this needs to be less permissive
        //            return nil
        //        }
        
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
        
        if !query.craft.isEmpty {
            result += QueryBuilder.catQuery + "craft=" + query.craft.map {
                $0.rawValue
            }
            .joined(separator: QueryBuilder.separator)
        }
        
        if !query.notebook.isEmpty {
            result += QueryBuilder.catQuery + "notebook-p=" + query.notebook.map {
                $0.rawValue
            }
            .joined(separator: QueryBuilder.separator)
        }
        
        if !query.availability.isEmpty {
            result += QueryBuilder.catQuery + "availability=" + query.availability.map {
                $0.rawValue
            }
            .joined(separator: QueryBuilder.separator)
        }
        
        if !query.weight.isEmpty {
            result += QueryBuilder.catQuery + "weight=" + query.weight.map {
                $0.rawValue
            }
            .joined(separator: QueryBuilder.separator)
        }
        
        return result
        
        //        if valid {
        //            return result
        //        }
        //        return nil
    }
}
