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
    
    enum CodingKeys: String, CodingKey {
        case inLibrary = "in_library"
        case favorited, queued
    }
    
    init(favorited: Bool?, queued: Bool?, inLibrary: Bool?) {
        self.favorited = favorited
        self.queued = queued
        self.inLibrary = inLibrary
    }
}

extension PersonalAttributes {
    static let mockData = PersonalAttributes(favorited: false, queued: false, inLibrary: true)
    static let emptyData = PersonalAttributes(favorited: nil, queued: nil, inLibrary: nil)
}
