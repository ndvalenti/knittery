//
//  PersonalAttributes.swift
//  Knittery
//
//  Created by Nick on 2022-10-04.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

struct PersonalAttributes: Codable {
    let favorited: Bool?
    let queued: Bool?
    let inLibrary: Bool?
    let bookmarkId: Int?
    
    enum CodingKeys: String, CodingKey {
        case inLibrary = "in_library"
        case bookmarkId = "bookmark_id"
        case favorited, queued
    }
    
    init(favorited: Bool?, queued: Bool?, inLibrary: Bool?, bookmarkId: Int?) {
        self.favorited = favorited
        self.queued = queued
        self.inLibrary = inLibrary
        self.bookmarkId = bookmarkId
    }
}

extension PersonalAttributes {
    static let mockData = PersonalAttributes(favorited: true, queued: false, inLibrary: false, bookmarkId: 1111)
    static let emptyData = PersonalAttributes(favorited: nil, queued: nil, inLibrary: nil, bookmarkId: nil)
}
