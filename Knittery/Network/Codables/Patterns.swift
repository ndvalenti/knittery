//
//  PatternSearch.swift
//  Knittery
//
//  Created by Nick on 2022-10-11.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

struct PatternSearch: Codable {
    let patterns: [PatternResult]
}

struct PatternResult: Codable {
    let free: Bool?
    let id: Int?
    let name: String?
    // TODO: designer, author need enum and separate codable
    let firstPhoto: Photo?
//    let designer: String?
//    let author: String? pattern_author
    
    enum CodingKeys: String, CodingKey {
        case firstPhoto = "first_photo"
        case free, id, name
    }
}

//{
//  "patterns": [
//    {
//      "free": true,
//      "id": 1278410,
//      "name": "Strata Cowl",
//      "permalink": "strata-cowl-6",
//      "personal_attributes": null,
//      "first_photo": {
//        "id": 115963775,
//        "sort_order": 1,
//        "x_offset": 0,
//        "y_offset": -29,
//        "square_url": "https://images4-g.ravelrycache.com/uploads/KPStaff/880416161/upload_square",
//        "medium_url": "https://images4-f.ravelrycache.com/uploads/KPStaff/880416161/upload_medium",
//        "thumbnail_url": "https://images4-f.ravelrycache.com/uploads/KPStaff/880416161/upload_thumbnail",
//        "small_url": "https://images4-f.ravelrycache.com/uploads/KPStaff/880416161/upload_small_best_fit",
//        "medium2_url": "https://images4-g.ravelrycache.com/uploads/KPStaff/880416161/upload_medium2",
//        "small2_url": "https://images4-g.ravelrycache.com/uploads/KPStaff/880416161/upload_small2",
//        "caption": null,
//        "caption_html": null,
//        "copyright_holder": "Knit Picks"
//      },
//      "designer": {
//        "crochet_pattern_count": 1,
//        "favorites_count": 57,
//        "id": 117213,
//        "knitting_pattern_count": 55,
//        "name": "Megan Gonzalez",
//        "patterns_count": 56,
//        "permalink": "megan-gonzalez",
//        "users": [
//          {
//            "id": 5475672,
//            "username": "MeganGonzalez",
//            "tiny_photo_url": "https://avatars-d.ravelrycache.com/MeganGonzalez/722287020/IMG_2588_tiny.jpg",
//            "small_photo_url": "https://avatars-d.ravelrycache.com/MeganGonzalez/722287020/IMG_2588_small.jpg",
//            "photo_url": "https://avatars-d.ravelrycache.com/MeganGonzalez/722287020/IMG_2588_large.jpg"
//          }
//        ]
//      },
//      "pattern_author": {
//        "crochet_pattern_count": 1,
//        "favorites_count": 57,
//        "id": 117213,
//        "knitting_pattern_count": 55,
//        "name": "Megan Gonzalez",
//        "patterns_count": 56,
//        "permalink": "megan-gonzalez",
//        "users": [
//          {
//            "id": 5475672,
//            "username": "MeganGonzalez",
//            "tiny_photo_url": "https://avatars-d.ravelrycache.com/MeganGonzalez/722287020/IMG_2588_tiny.jpg",
//            "small_photo_url": "https://avatars-d.ravelrycache.com/MeganGonzalez/722287020/IMG_2588_small.jpg",
//            "photo_url": "https://avatars-d.ravelrycache.com/MeganGonzalez/722287020/IMG_2588_large.jpg"
//          }
//        ]
//      },
//      "pattern_sources": [
//        {
//          "amazon_rating": null,
//          "amazon_reviews": null,
//          "amazon_sales_rank": null,
//          "amazon_updated_at": null,
//          "amazon_url": null,
//          "approved_patterns_count": 3729,
//          "asin": "",
//          "author": "",
//          "author_pattern_author_id": null,
//          "author_surname": "",
//          "book_binding": null,
//          "completed": false,
//          "created_at": null,
//          "created_by_user_id": 247,
//          "designer_pending_patterns_count": 114,
//          "designer_users_count": 1178,
//          "editorships_count": 5,
//          "favorites_count": 613,
//          "first_photo_id": null,
//          "flaggings_count": 0,
//          "fulfilled_by_ravelry": false,
//          "has_photo": false,
//          "id": 71,
//          "isbn_13": null,
//          "issue": "Knit Picks Website",
//          "keywords": "Web-site, knitpicks, knitpicks.com, IDP, knit picks.com, knit picks, knit picks independent designer program, knit picks",
//          "label": null,
//          "large_image_url": null,
//          "last_pattern_edit": "2022/10/10 17:57:32 -0400",
//          "link_id": 1968,
//          "list_price": null,
//          "lock_version": 44,
//          "medium_image_url": null,
//          "name": "Knit Picks Website",
//          "out_of_print": false,
//          "pattern_source_type_id": 3,
//          "patterns_count": 5062,
//          "pending_patterns_count": 1333,
//          "periodical": true,
//          "permalink": "knit-picks-website",
//          "photos_permitted": true,
//          "popularity": 0.0,
//          "popularity_rank": 6,
//          "price": null,
//          "publication_date": null,
//          "publication_date_set": 0,
//          "publication_day_set": 0,
//          "publication_sort_order": null,
//          "publication_year": null,
//          "publisher_id": null,
//          "shelf_image_path": null,
//          "shelf_image_size": null,
//          "small_image_url": null,
//          "source_group_id": 317,
//          "stickies_count": 0,
//          "store_id": null,
//          "updated_at": "2022/04/07 08:30:44 -0400",
//          "url": "http://www.knitpicks.com",
//          "work_id": null,
//          "notes": "Registration may be required for free patterns."
//        }
//      ]
//    },
//    {
//      "free": false,
//      "id": 1278343,
//      "name": "No Rhinebeck, no problem! 2 MKAL",
//      "permalink": "no-rhinebeck-no-problem-2-mkal",
//      "personal_attributes": null,
//      "first_photo": {
//        "id": 115957575,
//        "sort_order": 1,
//        "x_offset": -6,
//        "y_offset": -18,
//        "square_url": "https://images4-f.ravelrycache.com/uploads/SweaterFreak/879512134/nrnp2_square.png",
//        "medium_url": "https://images4-g.ravelrycache.com/uploads/SweaterFreak/879512134/nrnp2_medium.png",
//        "thumbnail_url": "https://images4-g.ravelrycache.com/uploads/SweaterFreak/879512134/nrnp2_thumbnail.png",
//        "small_url": "https://images4-g.ravelrycache.com/uploads/SweaterFreak/879512134/nrnp2_small.png",
//        "medium2_url": "https://images4-f.ravelrycache.com/uploads/SweaterFreak/879512134/nrnp2_medium2.png",
//        "small2_url": "https://images4-f.ravelrycache.com/uploads/SweaterFreak/879512134/nrnp2_small2.png",
//        "caption": null,
//        "caption_html": null,
//        "copyright_holder": null
//      },
//      "designer": {
//        "crochet_pattern_count": 0,
//        "favorites_count": 2979,
//        "id": 19866,
//        "knitting_pattern_count": 158,
//        "name": "SweaterFreak",
//        "patterns_count": 158,
//        "permalink": "sweaterfreak",
//        "users": [
//          {
//            "id": 38692,
//            "username": "SweaterFreak",
//            "tiny_photo_url": "https://avatars-d.ravelrycache.com/SweaterFreak/533274985/IMG_1126_medium2_tiny.JPG",
//            "small_photo_url": "https://avatars-d.ravelrycache.com/SweaterFreak/533274985/IMG_1126_medium2_small.JPG",
//            "photo_url": "https://avatars-d.ravelrycache.com/SweaterFreak/533274985/IMG_1126_medium2_large.JPG"
//          }
//        ]
//      },
//      "pattern_author": {
//        "crochet_pattern_count": 0,
//        "favorites_count": 2979,
//        "id": 19866,
//        "knitting_pattern_count": 158,
//        "name": "SweaterFreak",
//        "patterns_count": 158,
//        "permalink": "sweaterfreak",
//        "users": [
//          {
//            "id": 38692,
//            "username": "SweaterFreak",
//            "tiny_photo_url": "https://avatars-d.ravelrycache.com/SweaterFreak/533274985/IMG_1126_medium2_tiny.JPG",
//            "small_photo_url": "https://avatars-d.ravelrycache.com/SweaterFreak/533274985/IMG_1126_medium2_small.JPG",
//            "photo_url": "https://avatars-d.ravelrycache.com/SweaterFreak/533274985/IMG_1126_medium2_large.JPG"
//          }
//        ]
//      },
//      "pattern_sources": [
//        {
//          "amazon_rating": null,
//          "amazon_reviews": null,
//          "amazon_sales_rank": null,
//          "amazon_updated_at": null,
//          "amazon_url": null,
//          "approved_patterns_count": 157,
//          "asin": "",
//          "author": "Sweaterfreak",
//          "author_pattern_author_id": 19866,
//          "author_surname": "SweaterFreak",
//          "book_binding": null,
//          "completed": false,
//          "created_at": "2013/01/03 18:32:02 -0500",
//          "created_by_user_id": 38692,
//          "designer_pending_patterns_count": 0,
//          "designer_users_count": 0,
//          "editorships_count": 0,
//          "favorites_count": 306,
//          "first_photo_id": null,
//          "flaggings_count": 0,
//          "fulfilled_by_ravelry": false,
//          "has_photo": false,
//          "id": 132177,
//          "isbn_13": null,
//          "issue": null,
//          "keywords": "Sweater Freak Knits, SweaterFreakKnits",
//          "label": null,
//          "large_image_url": null,
//          "last_pattern_edit": "2022/10/10 14:16:11 -0400",
//          "link_id": 300690,
//          "list_price": null,
//          "lock_version": 7,
//          "medium_image_url": null,
//          "name": "SweaterFreak on Ravelry",
//          "out_of_print": false,
//          "pattern_source_type_id": 7,
//          "patterns_count": 157,
//          "pending_patterns_count": 0,
//          "periodical": false,
//          "permalink": "sweaterfreak-on-ravelry",
//          "photos_permitted": false,
//          "popularity": 0.0,
//          "popularity_rank": 2147483647,
//          "price": null,
//          "publication_date": null,
//          "publication_date_set": 0,
//          "publication_day_set": 0,
//          "publication_sort_order": null,
//          "publication_year": null,
//          "publisher_id": null,
//          "shelf_image_path": null,
//          "shelf_image_size": null,
//          "small_image_url": null,
//          "source_group_id": null,
//          "stickies_count": 1,
//          "store_id": 3419,
//          "updated_at": "2022/02/08 03:33:26 -0500",
//          "url": "http://www.ravelry.com/stores/jenny-faifel-designs",
//          "work_id": null,
//          "notes": ""
//        }
//      ]
//    },
