//
//  Pattern.swift
//  Knittery
//
//  Created by Nick on 2022-10-02.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

struct PatternWrapper: Codable {
    let pattern: Pattern
}

struct Pattern: Codable {
    let id: Int
    let name: String
    // author requires another codable
//    let author: String
    let craft: Craft
    let personalAttributes: PersonalAttributes
    let yardage: Int
    let createdAt: String
    let urlLink: String
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case urlLink = "permalink"
        case personalAttributes = "personal_attributes"
        case id, name, craft, yardage
    }
}
