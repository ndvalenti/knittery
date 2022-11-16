//
//  Designer.swift
//  Knittery
//
//  Created by Nick on 2022-11-10.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

struct Designer: Codable {
    let id: Int?
    let name: String?
    let users: [User]
    
    init(id: Int?, name: String?, users: [User]) {
        self.id = id
        self.name = name
        self.users = users
    }
}

extension Designer {
    static let mockData = Designer(id: 9999, name: "Designer Designerson", users: [User.mockData])
}
