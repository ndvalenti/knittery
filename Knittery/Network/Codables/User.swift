//
//  User.swift
//  Knittery
//
//  Created by Nick on 2022-10-04.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

struct UserWrapper: Codable {
    let user: User?
}

struct User: Codable {
    let id: Int?
    let username: String?
    let photo: String?
    
    enum CodingKeys: String, CodingKey {
        case photo = "tiny_photo_url"
        case id, username
    }
    
    init(id: Int?, username: String?, photo: String?) {
        self.id = id
        self.username = username
        self.photo = photo
    }
}

extension User {
    static let mockData = User(id: 3333, username: "User Userson", photo: "https://avatars-d.ravelrycache.com/SharpDog/886529785/knitteryS_tiny.jpeg")
}
