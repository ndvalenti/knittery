//
//  Photo.swift
//  Knittery
//
//  Created by Nick on 2022-10-11.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

struct Photo: Codable {
    let id: Int?
    let sortOrder: Int?
    let thumbnail: URL?
    let smallURL: URL?
    let squareURL: URL?
    let mediumURL: URL?
    let copyright: String?
    
    enum CodingKeys: String, CodingKey {
        case sortOrder = "sort_order"
        case thumbnail = "thumbnail_url"
        case smallURL = "small_url"
        case squareURL = "square_url"
        case mediumURL = "medium_url"
        case copyright = "copyright_holder"
        case id
    }
    
    init(id: Int?, sortOrder: Int?, thumbnail: URL?, smallURL: URL?, squareURL: URL?, mediumURL: URL?, copyright: String?) {
        self.id = id
        self.sortOrder = sortOrder
        self.thumbnail = thumbnail
        self.smallURL = smallURL
        self.squareURL = squareURL
        self.mediumURL = mediumURL
        self.copyright = copyright
    }
}

extension Photo {
    static let mockData = Photo(id: 60379800,
                                sortOrder: 1,
                                thumbnail: URL(string:"https://images4-g.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_thumbnail.jpg"),
                                smallURL: URL(string:"https://images4-g.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_small_best_fit.jpg"),
                                squareURL: URL(string: "https://images4-f.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_square.jpg"),
//                                squareURL: URL(string: "https://images4-f.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_shelved.jpg"),
                                mediumURL: URL(string:  "https://images4-f.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_medium.jpg"),
                                copyright: "Coats & Clark")
}
