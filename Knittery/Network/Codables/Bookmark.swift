//
//  Bookmark.swift
//  Knittery
//
//  Created by Nick on 2022-12-06.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

struct BookmarkWrapper: Codable {
    let bookmark: Bookmark
}

struct Bookmark: Codable {
    let id: Int?
    
    init(id: Int?) {
        self.id = id
    }
}

extension Bookmark {
    static let mockData = Bookmark(id: 1)
    static let emptyData = Bookmark(id: nil)
}
