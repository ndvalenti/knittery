//
//  Author.swift
//  Knittery
//
//  Created by Nick on 2022-11-10.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

struct Author: Codable {
    let id: Int?
    let name: String?
    let users: [User]
    
    init(id: Int?, name: String?, users: [User]) {
        self.id = id
        self.name = name
        self.users = users
    }
}

extension Author {
    static let mockData = Author(id: 1234, name: "Author Authorson", users: [User.mockData])
}
