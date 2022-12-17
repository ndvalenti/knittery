//
//  QueryBuilder.swift
//  Knittery
//
//  Created by Nick on 2022-10-12.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

class QueryBuilder {
    static private let startSymbol = "?"
    static private let orSeparator = "%7C"
    static private let andSeparator = "%2B"
    static private let space = "%20"
    static private let concat = "&"
    static private let invertSymbol = "_"
    
    static func build(_ query: Query) -> String {
        var resultBuilder: String
        var result = QueryBuilder.startSymbol
        
        // TODO: Determine behavior when query not supplied and adjust permissiveness of query
        result += "query=" + query.search.replacingOccurrences(of: " ", with: "%20")
        
        if let category = query.category {
            result += QueryBuilder.concat + "pc=" + category
        }
        
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
                    resultBuilder += QueryBuilder.andSeparator
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
                    resultBuilder += QueryBuilder.andSeparator
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
                    resultBuilder += QueryBuilder.andSeparator
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
                    resultBuilder += QueryBuilder.andSeparator
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
