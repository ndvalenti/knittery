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
    
    var query: Query? {
        switch self {
        case .newPatterns:
            return Query(sort: QSort.newest, requireImages: true, pageSize: "15")
        case .hotPatterns:
            return Query(sort: QSort.best, requireImages: true, pageSize: "15")
        case .randomPatterns:
            return Query(sort: QSort.randomize, requireImages: true, pageSize: "15")
        case .debutPatterns:
            return Query(sort: QSort.newest, requireImages: true, pageSize: "15", append: "debut-pattern=yes")
        case .libraryPatterns:
            return Query(sort: QSort.randomize, pageSize: "15", notebook: [.library])
        case .favoritePatterns:
            return Query(sort: QSort.randomize, pageSize: "15", notebook: [.favorites])
        }
    }
}
