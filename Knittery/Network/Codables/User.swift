//
//  User.swift
//  Knittery
//
//  Created by Nick on 2022-10-04.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

// TODO: fetch user information and cache it on log in

import Foundation

struct UserWrapper: Codable {
    let user: User?
}

struct User: Codable {
    let id: Int?
    let username: String?
    let photoURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case photoURL = "tiny_photo_url"
        case id, username
    }
    
    init(id: Int?, username: String?, photo: URL?) {
        self.id = id
        self.username = username
        self.photoURL = photo
    }
}

extension User {
    static let mockData = User(id: 3333, username: "User Userson", photo: URL(string: "https://avatars-d.ravelrycache.com/SharpDog/886529785/knitteryS_tiny.jpeg"))
}
