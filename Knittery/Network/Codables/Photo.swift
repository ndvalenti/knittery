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
    let thumbnail: String?
    let small: String?
    let copyright: String?
    
    enum CodingKeys: String, CodingKey {
        case sortOrder = "sort_order"
        case thumbnail = "thumbnail_url"
        case small = "small_url"
        case copyright = "copyright_holder"
        case id
    }
}

//"photos": [
//      {
//        "id": 60379800,
//        "sort_order": 1,
//        "x_offset": 0,
//        "y_offset": -17,
//        "square_url": "https://images4-f.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_square.jpg",
//        "medium_url": "https://images4-f.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_medium.jpg",
//        "thumbnail_url": "https://images4-g.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_thumbnail.jpg",
//        "small_url": "https://images4-g.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_small_best_fit.jpg",
//        "flickr_url": null,
//        "shelved_url": "https://images4-f.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_shelved.jpg",
//        "medium2_url": "https://images4-g.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_medium2.jpg",
//        "small2_url": "https://images4-f.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_small2.jpg",
//        "caption": null,
//        "caption_html": null,
//        "copyright_holder": "Coats & Clark"
//      },
