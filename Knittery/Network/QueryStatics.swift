//
//  QueryStatics.swift
//  Knittery
//
//  Created by Nick on 2022-12-02.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

enum DefaultContent: String, CaseIterable, RawRepresentable {
    case newPatterns = "Recently Added"// recently added
    case hotPatterns = "Hot Right Now"// hot right now, recently-popular
    case randomPatterns = "Randomly Selected"
    case debutPatterns = "Debut Patterns"// debut-pattern=yes
    case libraryPatterns = "Library"
    case favoritePatterns = "Favorited"
    
    var query: String? {
        switch self {
        case .newPatterns:
            return QueryBuilder.build(Query(sort: QSort.newest, requireImages: true, pageSize: "15"))
        case .hotPatterns:
            return QueryBuilder.build(Query(sort: QSort.best, requireImages: true, pageSize: "15"))
        case .randomPatterns:
            return QueryBuilder.build(Query(sort: QSort.randomize, requireImages: true, pageSize: "15"))
        case .debutPatterns:
            return QueryBuilder.build(Query(sort: QSort.newest, requireImages: true, pageSize: "15", append: "debut-pattern=yes"))
        case .libraryPatterns:
            return QueryBuilder.build(Query(pageSize: "15", notebook: [.library]))
        case .favoritePatterns:
            return QueryBuilder.build(Query(pageSize: "15", notebook: [.favorites]))
        }
    }
}
