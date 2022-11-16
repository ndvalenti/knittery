//
//  Pattern.swift
//  Knittery
//
//  Created by Nick on 2022-10-02.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

// TODO: Some of this information might be able to be fetched one time and cached, such as needle types, categories, and pattern attributes

struct PatternWrapper: Codable {
    let pattern: Pattern?
}

struct Pattern: Codable {
    let id: Int?
    let name: String?
    let author: Author
    let free: Bool
    let craft: Craft
    let difficulty: Double
    let rating: Double
    let personalAttributes: PersonalAttributes
    let yardage: Int?
    let yarnWeight: YarnWeight
    let needleSizes: [NeedleSize]
    let sizesAvailable: String?
    let photos: [Photo]
    let createdAt: String?
    let url: String?
    let permalink: String?
    let notes: String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case personalAttributes = "personal_attributes"
        case yarnWeight = "yarn_weight"
        case sizesAvailable = "sizes_available"
        case rating = "rating_average"
        case difficulty = "difficulty_average"
        case needleSizes = "pattern_needle_sizes"
        case id, name, free, craft, yardage, photos, author, url, notes, permalink
    }
    
    init(id: Int?, name: String?, author: Author, free: Bool = false, craft: Craft, difficulty: Double = 0.0, rating: Double = 0.0, personalAttributes: PersonalAttributes, yardage: Int?, yarnWeight: YarnWeight, needleSizes: [NeedleSize], sizesAvailable: String?, photos: [Photo], createdAt: String?, url: String?, permalink: String?, notes: String?) {
        self.id = id
        self.name = name
        self.author = author
        self.free = free
        self.craft = craft
        self.difficulty = difficulty
        self.rating = rating
        self.personalAttributes = personalAttributes
        self.yardage = yardage
        self.yarnWeight = yarnWeight
        self.needleSizes = needleSizes
        self.sizesAvailable = sizesAvailable
        self.photos = photos
        self.createdAt = createdAt
        self.url = url
        self.permalink = permalink
        self.notes = notes
    }
}
// yarn weight, hook size, sizes available

extension Pattern {
    static let mockData = Pattern(id: 688190, name: "Speckled Super Scarf", author: Author.mockData, free: true, craft: Craft.mockData, difficulty: 2.29, personalAttributes: PersonalAttributes.mockData, yardage: 708, yarnWeight: YarnWeight.mockData, needleSizes: [NeedleSize.mockData], sizesAvailable: "Scarf measures 10.5” [26.5 cm] wide by 90” [228.5 cm] long.", photos: [Photo.mockData, Photo.mockData, Photo.mockData], createdAt: "2016/09/06 14:58:22 -0400", url: "https://www.yarnspirations.com/row-en/red-heart-speckled-super-scarf/RHC0125-024654M.html", permalink: "speckled-super-scarf",
                                  notes: "Simple, but oh so attractive, this over-sized scarf is just what you need to update last year’s wardrobe. Ours is 90” long in a neutral heather, but you can make your Super Scarf any length and any color you desire. This is an easy crochet in a variation of the basic ripple stitch.\r\n\r\nGAUGE: 24 sts (2 ripples) = 7” (18 cm); 5 rows = 4” (10cm) CHECK YOUR GAUGE.\r\n\r\nAlso as [Speckled Super Scarf][1] and [Wavy Ridge][2]\r\n\r\n\r\n  [1]: http://www.redheart.com/free-patterns/speckled-super-scarf\r\n  [2]: https://www.yarnspirations.com/red-heart-wavy-ridge-super-scarf/RHC0125-016921M.html#q=Wavy+ridge&includeContent=true&start=2")
}

/*
 {
   "pattern": {
     "comments_count": 1,
     "created_at": "2016/09/06 14:58:22 -0400",
     "currency": "USD",
     "difficulty_average": 2.2903225806451615,
     "difficulty_count": 31,
     "downloadable": true,
     "favorites_count": 1563,
     "free": true,
     "gauge": null,
     "gauge_divisor": 4,
     "gauge_pattern": "",
     "generally_available": "2016/09/06 14:58:22 -0400",
     "id": 688190,
     "name": "Speckled Super Scarf",
     "pdf_url": "",
     "permalink": "speckled-super-scarf",
     "price": null,
     "projects_count": 130,
     "published": "2016/09/01",
     "queued_projects_count": 146,
     "rating_average": 4.689655172413793,
     "rating_count": 29,
     "row_gauge": null,
     "updated_at": "2019/12/05 13:44:09 -0500",
     "url": "https://www.yarnspirations.com/row-en/red-heart-speckled-super-scarf/RHC0125-024654M.html",
     "yardage": 708,
     "yardage_max": null,
     "personal_attributes": {
       "favorited": false,
       "bookmark_id": null,
       "queued": false,
       "in_library": true
     },
     "sizes_available": "Scarf measures 10.5” [26.5 cm] wide by 90” [228.5 cm] long.",
     "product_id": null,
     "currency_symbol": "$",
     "ravelry_download": false,
     "download_location": {
       "type": "external",
       "free": true,
       "url": "https://www.yarnspirations.com/row-en/red-heart-speckled-super-scarf/RHC0125-024654M.html"
     },
     "pdf_in_library": false,
     "volumes_in_library": [],
     "gauge_description": "",
     "yarn_weight_description": "Aran (8 wpi)",
     "yardage_description": "708 yards",
     "pattern_needle_sizes": [
       {
         "id": 11,
         "us": "10.5",
         "metric": 6.5,
         "us_steel": null,
         "crochet": true,
         "knitting": false,
         "hook": "K",
         "name": "6.5 mm (K)",
         "pretty_metric": "6.5"
       }
     ],
     "notes_html": "\n<p>Simple, but oh so attractive, this over-sized scarf is just what you need to update last year’s wardrobe. Ours is 90” long in a neutral heather, but you can make your Super Scarf any length and any color you desire. This is an easy crochet in a variation of the basic ripple stitch.</p>\n\n<p>GAUGE: 24 sts (2 ripples) = 7” (18 cm); 5 rows = 4” (10cm) CHECK YOUR GAUGE.</p>\n\n<p>Also as <a href=\"http://www.redheart.com/free-patterns/speckled-super-scarf\">Speckled Super Scarf</a> and <a href=\"https://www.yarnspirations.com/red-heart-wavy-ridge-super-scarf/RHC0125-016921M.html#q=Wavy+ridge&amp;includeContent=true&amp;start=2\">Wavy Ridge</a></p>\n",
     "notes": "Simple, but oh so attractive, this over-sized scarf is just what you need to update last year’s wardrobe. Ours is 90” long in a neutral heather, but you can make your Super Scarf any length and any color you desire. This is an easy crochet in a variation of the basic ripple stitch.\r\n\r\nGAUGE: 24 sts (2 ripples) = 7” (18 cm); 5 rows = 4” (10cm) CHECK YOUR GAUGE.\r\n\r\nAlso as [Speckled Super Scarf][1] and [Wavy Ridge][2]\r\n\r\n\r\n  [1]: http://www.redheart.com/free-patterns/speckled-super-scarf\r\n  [2]: https://www.yarnspirations.com/red-heart-wavy-ridge-super-scarf/RHC0125-016921M.html#q=Wavy+ridge&includeContent=true&start=2",
     "packs": [
       {
         "id": 58474753,
         "primary_pack_id": null,
         "project_id": null,
         "skeins": null,
         "stash_id": null,
         "total_grams": null,
         "total_meters": null,
         "total_ounces": null,
         "total_yards": null,
         "yarn_id": 2059,
         "yarn_name": "Red Heart Super Saver Solids",
         "yarn_weight": {
           "crochet_gauge": "",
           "id": 1,
           "knit_gauge": "18",
           "max_gauge": null,
           "min_gauge": null,
           "name": "Aran",
           "ply": "10",
           "wpi": "8"
         },
         "colorway": null,
         "shop_name": null,
         "yarn": {
           "permalink": "red-heart-super-saver-solids",
           "id": 2059,
           "name": "Super Saver Solids",
           "yarn_company_name": "Red Heart",
           "yarn_company_id": 108
         },
         "quantity_description": null,
         "personal_name": null,
         "dye_lot": null,
         "color_family_id": null,
         "grams_per_skein": null,
         "yards_per_skein": null,
         "meters_per_skein": null,
         "ounces_per_skein": null,
         "prefer_metric_weight": true,
         "prefer_metric_length": false,
         "shop_id": null,
         "thread_size": null
       }
     ],
     "printings": [
       {
         "primary_source": true,
         "pattern_source": {
           "amazon_rating": null,
           "amazon_url": null,
           "author": "",
           "id": 150543,
           "list_price": null,
           "name": "Yarnspirations Patterns",
           "out_of_print": false,
           "patterns_count": 8777,
           "permalink": "yarnspirations-patterns",
           "price": null,
           "shelf_image_path": null,
           "url": "http://www.yarnspirations.com/"
         }
       },
       {
         "primary_source": false,
         "pattern_source": {
           "amazon_rating": null,
           "amazon_url": null,
           "author": "",
           "id": 36789,
           "list_price": null,
           "name": "Red Heart North America Website",
           "out_of_print": true,
           "patterns_count": 3566,
           "permalink": "red-heart-north-america-website",
           "price": null,
           "shelf_image_path": null,
           "url": "http://www.redheart.com"
         }
       },
       {
         "primary_source": false,
         "pattern_source": {
           "amazon_rating": null,
           "amazon_url": "https://www.amazon.com/Crochet-Scarves-Weekend-Textured-Projects/dp/1640210377?SubscriptionId=AKIAIVR5RCD3ZTXIG7RA&tag=ravelry-20&linkCode=xm2&camp=2025&creative=165953&creativeASIN=1640210377",
           "author": "Red Heart Yarns",
           "id": 272580,
           "list_price": "$12.95",
           "name": "Crochet Scarves, Shawls, & Ponchos in a Weekend",
           "out_of_print": false,
           "patterns_count": 9,
           "permalink": "crochet-scarves-shawls--ponchos-in-a-weekend",
           "price": "$12.95",
           "shelf_image_path": "http://images4.ravelry.com/uploads/nobody/664683603/51hxlbkrswl_shelved.jpg",
           "url": "https://www.go-crafty.com/crochet-scarves-shawls-ponchos-in-a-weekend"
         }
       }
     ],
     "yarn_weight": {
       "crochet_gauge": "",
       "id": 1,
       "knit_gauge": "18",
       "max_gauge": null,
       "min_gauge": null,
       "name": "Aran",
       "ply": "10",
       "wpi": "8"
     },
     "craft": {
       "id": 1,
       "name": "Crochet",
       "permalink": "crochet"
     },
     "pattern_categories": [
       {
         "id": 339,
         "name": "Scarf",
         "permalink": "scarf",
         "parent": {
           "id": 338,
           "name": "Neck / Torso",
           "permalink": "neck-torso",
           "parent": {
             "id": 337,
             "name": "Accessories",
             "permalink": "accessories",
             "parent": {
               "id": 301,
               "name": "Categories",
               "permalink": "categories"
             }
           }
         }
       }
     ],
     "pattern_attributes": [
       {
         "id": 10,
         "permalink": "adult"
       },
       {
         "id": 57,
         "permalink": "chevron"
       },
       {
         "id": 204,
         "permalink": "one-piece"
       },
       {
         "id": 267,
         "permalink": "written-pattern"
       },
       {
         "id": 285,
         "permalink": "worked-flat"
       }
     ],
     "pattern_author": {
       "crochet_pattern_count": 50,
       "favorites_count": 272,
       "id": 117,
       "knitting_pattern_count": 150,
       "name": "Heather Lodinsky",
       "patterns_count": 200,
       "permalink": "heather-lodinsky",
       "notes": "",
       "notes_html": null,
       "users": []
     },
     "photos": [
       {
         "id": 60379800,
         "sort_order": 1,
         "x_offset": 0,
         "y_offset": -17,
         "square_url": "https://images4-f.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_square.jpg",
         "medium_url": "https://images4-f.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_medium.jpg",
         "thumbnail_url": "https://images4-g.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_thumbnail.jpg",
         "small_url": "https://images4-g.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_small_best_fit.jpg",
         "flickr_url": null,
         "shelved_url": "https://images4-f.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_shelved.jpg",
         "medium2_url": "https://images4-g.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_medium2.jpg",
         "small2_url": "https://images4-f.ravelrycache.com/uploads/redheartyarns/396471592/LW5414-insetA_small2.jpg",
         "caption": null,
         "caption_html": null,
         "copyright_holder": "Coats & Clark"
       },
       {
         "id": 67877374,
         "sort_order": 2,
         "x_offset": 0,
         "y_offset": -17,
         "square_url": "https://images4-g.ravelrycache.com/uploads/redheartyarns/458678060/LM5489_square.jpg",
         "medium_url": "https://images4-g.ravelrycache.com/uploads/redheartyarns/458678060/LM5489_medium.jpg",
         "thumbnail_url": "https://images4-f.ravelrycache.com/uploads/redheartyarns/458678060/LM5489_thumbnail.jpg",
         "small_url": "https://images4-g.ravelrycache.com/uploads/redheartyarns/458678060/LM5489_small_best_fit.jpg",
         "flickr_url": null,
         "shelved_url": "https://images4-f.ravelrycache.com/uploads/redheartyarns/458678060/LM5489_shelved.jpg",
         "medium2_url": "https://images4-f.ravelrycache.com/uploads/redheartyarns/458678060/LM5489_medium2.jpg",
         "small2_url": "https://images4-g.ravelrycache.com/uploads/redheartyarns/458678060/LM5489_small2.jpg",
         "caption": null,
         "caption_html": null,
         "copyright_holder": "Coats & Clark"
       },
       {
         "id": 68902909,
         "sort_order": 3,
         "x_offset": -66,
         "y_offset": 0,
         "square_url": "https://images4-f.ravelrycache.com/uploads/rhiannon8404/424175904/2017-01-15_23.14.49_square.jpg",
         "medium_url": "https://images4-f.ravelrycache.com/uploads/rhiannon8404/424175904/2017-01-15_23.14.49_medium.jpg",
         "thumbnail_url": "https://images4-g.ravelrycache.com/uploads/rhiannon8404/424175904/2017-01-15_23.14.49_thumbnail.jpg",
         "small_url": "https://images4-g.ravelrycache.com/uploads/rhiannon8404/424175904/2017-01-15_23.14.49_small_best_fit.jpg",
         "flickr_url": null,
         "shelved_url": "https://images4-g.ravelrycache.com/uploads/rhiannon8404/424175904/2017-01-15_23.14.49_shelved.jpg",
         "medium2_url": "https://images4-g.ravelrycache.com/uploads/rhiannon8404/424175904/2017-01-15_23.14.49_medium2.jpg",
         "small2_url": "https://images4-f.ravelrycache.com/uploads/rhiannon8404/424175904/2017-01-15_23.14.49_small2.jpg",
         "caption": null,
         "caption_html": null,
         "copyright_holder": "rhiannon8404"
       },
       {
         "id": 67452675,
         "sort_order": 4,
         "x_offset": -5,
         "y_offset": -35,
         "square_url": "https://images4-f.ravelrycache.com/uploads/Gigi2001/431954925/IMG_1986_square.JPG",
         "medium_url": "https://images4-f.ravelrycache.com/uploads/Gigi2001/431954925/IMG_1986_medium.JPG",
         "thumbnail_url": "https://images4-g.ravelrycache.com/uploads/Gigi2001/431954925/IMG_1986_thumbnail.JPG",
         "small_url": "https://images4-f.ravelrycache.com/uploads/Gigi2001/431954925/IMG_1986_small.JPG",
         "flickr_url": null,
         "shelved_url": "https://images4-f.ravelrycache.com/uploads/Gigi2001/431954925/IMG_1986_shelved.JPG",
         "medium2_url": "https://images4-g.ravelrycache.com/uploads/Gigi2001/431954925/IMG_1986_medium2.JPG",
         "small2_url": "https://images4-f.ravelrycache.com/uploads/Gigi2001/431954925/IMG_1986_small2.JPG",
         "caption": null,
         "caption_html": null,
         "copyright_holder": "Gigi2001"
       },
       {
         "id": 60379801,
         "sort_order": 5,
         "x_offset": 0,
         "y_offset": -17,
         "square_url": "https://images4-f.ravelrycache.com/uploads/redheartyarns/396471609/LW5414_square.jpg",
         "medium_url": "https://images4-f.ravelrycache.com/uploads/redheartyarns/396471609/LW5414_medium.jpg",
         "thumbnail_url": "https://images4-f.ravelrycache.com/uploads/redheartyarns/396471609/LW5414_thumbnail.jpg",
         "small_url": "https://images4-f.ravelrycache.com/uploads/redheartyarns/396471609/LW5414_small_best_fit.jpg",
         "flickr_url": null,
         "shelved_url": "https://images4-g.ravelrycache.com/uploads/redheartyarns/396471609/LW5414_shelved.jpg",
         "medium2_url": "https://images4-f.ravelrycache.com/uploads/redheartyarns/396471609/LW5414_medium2.jpg",
         "small2_url": "https://images4-f.ravelrycache.com/uploads/redheartyarns/396471609/LW5414_small2.jpg",
         "caption": null,
         "caption_html": null,
         "copyright_holder": "Coats & Clark"
       },
       {
         "id": 67877372,
         "sort_order": 6,
         "x_offset": 0,
         "y_offset": -17,
         "square_url": "https://images4-g.ravelrycache.com/uploads/redheartyarns/458678058/LM5489inset1_square.jpg",
         "medium_url": "https://images4-g.ravelrycache.com/uploads/redheartyarns/458678058/LM5489inset1_medium.jpg",
         "thumbnail_url": "https://images4-g.ravelrycache.com/uploads/redheartyarns/458678058/LM5489inset1_thumbnail.jpg",
         "small_url": "https://images4-f.ravelrycache.com/uploads/redheartyarns/458678058/LM5489inset1_small_best_fit.jpg",
         "flickr_url": null,
         "shelved_url": "https://images4-g.ravelrycache.com/uploads/redheartyarns/458678058/LM5489inset1_shelved.jpg",
         "medium2_url": "https://images4-f.ravelrycache.com/uploads/redheartyarns/458678058/LM5489inset1_medium2.jpg",
         "small2_url": "https://images4-g.ravelrycache.com/uploads/redheartyarns/458678058/LM5489inset1_small2.jpg",
         "caption": null,
         "caption_html": null,
         "copyright_holder": "Coats & Clark"
       }
     ],
     "pattern_type": {
       "clothing": true,
       "id": 1,
       "name": "Scarf",
       "permalink": "scarf"
     }
   }
 }
 */
