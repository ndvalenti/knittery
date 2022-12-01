//
//  Photo.swift
//  Knittery
//
//  Created by Nick on 2022-10-11.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

struct Photo: Codable, Identifiable, Hashable {
    let id: Int?
    let sortOrder: Int?
    let thumbnail: URL?
    let smallURL: URL?
    let squareURL: URL?
    let mediumURL: URL?
    let medium2URL: URL?
    let copyright: String?
    
    enum CodingKeys: String, CodingKey {
        case sortOrder = "sort_order"
        case thumbnail = "thumbnail_url"
        case smallURL = "small_url"
        case squareURL = "square_url"
        case mediumURL = "medium_url"
        case medium2URL = "medium2_url"
        case copyright = "copyright_holder"
        case id
    }
    
    init(id: Int?, sortOrder: Int?, thumbnail: URL?, smallURL: URL?, squareURL: URL?, mediumURL: URL?, medium2URL: URL?, copyright: String?) {
        self.id = id
        self.sortOrder = sortOrder
        self.thumbnail = thumbnail
        self.smallURL = smallURL
        self.squareURL = squareURL
        self.mediumURL = mediumURL
        self.medium2URL = medium2URL
        self.copyright = copyright
    }
}

extension Photo {
    static let mockData = Photo(id: 1,
                                sortOrder: 1,
                                thumbnail: URL(string:"https://images4-g.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_thumbnail.jpg"),
                                smallURL: URL(string:"https://images4-g.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_small_best_fit.jpg"),
                                squareURL: URL(string: "https://images4-f.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_square.jpg"),
                                mediumURL: URL(string:  "https://images4-f.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_medium.jpg"),
                                medium2URL: URL(string:"https://images4-f.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_medium2.jpg"),
                                copyright: "Coats & Clark")
    static let mockData2 = Photo(id: 2,
                                 sortOrder: 2,
                                 thumbnail: URL(string:"https://images4-g.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_thumbnail.jpg"),
                                 smallURL: URL(string:"https://images4-g.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_small_best_fit.jpg"),
                                 squareURL: URL(string: "https://images4-f.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_square.jpg"),
                                 mediumURL: URL(string:  "https://images4-f.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_medium.jpg"),
                                 medium2URL: URL(string:"https://images4-f.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_medium2.jpg"),
                                 copyright: "Coats & Clark")
    static let emptyData = Photo(id: nil, sortOrder: nil, thumbnail: nil, smallURL: nil, squareURL: nil, mediumURL: nil, medium2URL: nil, copyright: nil)
}
