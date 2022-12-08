//
//  Favorite.swift
//  Knittery
//
//  Created by Nick on 2022-12-06.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

struct Favorite: Codable {
    var id: String
    var type: String
    var comment: String
    
    var jsonData: Data? {
        try? JSONEncoder().encode(self)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "favorited_id"
        case type, comment
    }
}
