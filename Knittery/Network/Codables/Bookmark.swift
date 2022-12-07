//
//  Bookmark.swift
//  Knittery
//
//  Created by Nick on 2022-12-06.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

struct BookmarkWrapper: Codable {
    let bookmark: Bookmark
}

struct Bookmark: Codable {
    let id: Int?
    
    init(id: Int?) {
        self.id = id
    }
}

extension Bookmark {
    static let mockData = Bookmark(id: 1)
    static let emptyData = Bookmark(id: nil)
}


//{
//  "bookmark": {
//    "created_at": "2022/12/06 08:29:38 -0500",
//    "id": 414676562,
//    "type": "pattern",
//    "tag_list": "",
//    "favorited": {
//      "id": 1293627,
//      "name": "Christmas Wreath, Fir Cones & Toadstools",
//      "permalink": "christmas-wreath-fir-cones--toadstools",
//      "first_photo": {
//        "id": 117282500,
//        "sort_order": 1,
//        "x_offset": -2,
//        "y_offset": -2,
//        "square_url": "https://images4-f.ravelrycache.com/uploads/Frankie-Brown/891078794/12_Toadstools_square.JPG",
//        "medium_url": "https://images4-g.ravelrycache.com/uploads/Frankie-Brown/891078794/12_Toadstools_medium.JPG",
//        "thumbnail_url": "https://images4-g.ravelrycache.com/uploads/Frankie-Brown/891078794/12_Toadstools_thumbnail.JPG",
//        "small_url": "https://images4-f.ravelrycache.com/uploads/Frankie-Brown/891078794/12_Toadstools_small_best_fit.JPG",
//        "medium2_url": "https://images4-f.ravelrycache.com/uploads/Frankie-Brown/891078794/12_Toadstools_medium2.JPG",
//        "small2_url": "https://images4-f.ravelrycache.com/uploads/Frankie-Brown/891078794/12_Toadstools_small2.JPG",
//        "caption": null,
//        "caption_html": null,
//        "copyright_holder": null
//      },
//      "designer": {
//        "crochet_pattern_count": 36,
//        "favorites_count": 13853,
//        "id": 14185,
//        "knitting_pattern_count": 535,
//        "name": "Frankie Brown",
//        "patterns_count": 571,
//        "permalink": "frankie-brown",
//        "users": [
//          {
//            "id": 154502,
//            "username": "Frankie-Brown",
//            "tiny_photo_url": "https://avatars-d.ravelrycache.com/Rosemily/1275069/Holes_Big_Swirl_tiny.JPG",
//            "small_photo_url": "https://avatars-d.ravelrycache.com/Rosemily/1275069/Holes_Big_Swirl_small.JPG",
//            "photo_url": "https://avatars-d.ravelrycache.com/Rosemily/1275069/Holes_Big_Swirl_large.JPG"
//          }
//        ]
//      },
//      "pattern_author": {
//        "crochet_pattern_count": 36,
//        "favorites_count": 13853,
//        "id": 14185,
//        "knitting_pattern_count": 535,
//        "name": "Frankie Brown",
//        "patterns_count": 571,
//        "permalink": "frankie-brown",
//        "users": [
//          {
//            "id": 154502,
//            "username": "Frankie-Brown",
//            "tiny_photo_url": "https://avatars-d.ravelrycache.com/Rosemily/1275069/Holes_Big_Swirl_tiny.JPG",
//            "small_photo_url": "https://avatars-d.ravelrycache.com/Rosemily/1275069/Holes_Big_Swirl_small.JPG",
//            "photo_url": "https://avatars-d.ravelrycache.com/Rosemily/1275069/Holes_Big_Swirl_large.JPG"
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
//          "approved_patterns_count": 182,
//          "asin": "",
//          "author": "Frankie Brown",
//          "author_pattern_author_id": 14185,
//          "author_surname": "Brown",
//          "book_binding": null,
//          "completed": false,
//          "created_at": "2008/08/17 11:08:02 -0400",
//          "created_by_user_id": 154502,
//          "designer_pending_patterns_count": 0,
//          "designer_users_count": 149,
//          "editorships_count": 0,
//          "favorites_count": 2038,
//          "first_photo_id": null,
//          "flaggings_count": 0,
//          "fulfilled_by_ravelry": false,
//          "has_photo": false,
//          "id": 27592,
//          "isbn_13": null,
//          "issue": null,
//          "keywords": "",
//          "label": null,
//          "large_image_url": null,
//          "last_pattern_edit": "2022/12/05 03:52:32 -0500",
//          "link_id": 69852,
//          "list_price": null,
//          "lock_version": 17,
//          "medium_image_url": null,
//          "name": "Frankie's Knitted Stuff",
//          "out_of_print": false,
//          "pattern_source_type_id": 7,
//          "patterns_count": 561,
//          "pending_patterns_count": 379,
//          "periodical": false,
//          "permalink": "frankies-knitted-stuff",
//          "photos_permitted": false,
//          "popularity": 0.0,
//          "popularity_rank": 95,
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
//          "stickies_count": 3,
//          "store_id": 2288,
//          "updated_at": "2017/09/19 16:17:58 -0400",
//          "url": "http://www.ravelry.com/stores/frankies-knitted-stuff",
//          "work_id": null,
//          "notes": ""
//        }
//      ]
//    },
//    "comment": "comment",
//    "bundles": []
//  }
//}
