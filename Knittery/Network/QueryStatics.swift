//
//  QueryStatics.swift
//  Knittery
//
//  Created by Nick on 2022-12-02.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

enum DefaultQuery: CaseIterable {
    case newPatterns // recently added
    case hotPatterns // hot right now, recently-popular
    case randomPatterns
    case debutPatterns // debut-pattern=yes
    case libraryPatterns
    case favoritePatterns
}

extension Query {
    static let newQuery = Query(sort: QSort.newest)
    static let hotQuery = Query(sort: QSort.best)
    static let randomQuery = Query(sort: QSort.randomize)
    static let debutQuery = Query(sort: QSort.newest, append: "debut-pattern=yes")
    static let libraryQuery = Query(notebook: [.library])
    static let favoriteQuery = Query(notebook: [.favorites])
}
