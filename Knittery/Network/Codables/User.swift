//
//  User.swift
//  Knittery
//
//  Created by Nick on 2022-10-04.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

struct UserWrapper: Codable {
    let user: User
}

struct User: Codable {
    let id: Int
    let username: String
    let photo: String?
    
    enum CodingKeys: String, CodingKey {
        case photo = "tiny_photo_url"
        case id, username
    }
}
