//
//  PatternCategories.swift
//  Knittery
//
//  Created by Nick on 2022-12-12.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

struct PatternCategories: Codable {
    let rootCategory: PatternCategory?
    
    enum CodingKeys: String, CodingKey {
        case rootCategory = "pattern_categories"
    }
}

struct PatternCategory: Codable {
    let id: Int?
    let name: String?
    let longname: String?
    let permalink: String?
    let children: [PatternCategory]?
    
    init(id: Int? = nil, name: String? = nil, longname: String? = nil, permalink: String? = nil, children: [PatternCategory]? = nil) {
        self.id = id
        self.name = name
        self.longname = longname
        self.permalink = permalink
        self.children = children
    }
    
    enum CodingKeys: String, CodingKey {
        case longname = "long_name"
        case id, name, permalink, children
    }
}
