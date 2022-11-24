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
    let author: Author?
    let free: Bool
    let craft: Craft?
    let difficulty: Double?
    let rating: Double?
    let personalAttributes: PersonalAttributes?
    let yardage: Int?
    let yarnWeight: YarnWeight?
    let needleSizes: [NeedleSize]?
    let sizesAvailable: String?
    let photos: [Photo]?
    let createdAt: String?
    let url: String?
    let permalink: String?
    let ravelryDownload: Bool?
    let downloadLocation: DownloadLocation?
    let notes: String?
    
    static let dateFormatter = DateFormatter()
    
    var createdAtDate: Date? {
        Pattern.dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss Z"
        if let created = createdAt {
            return Pattern.dateFormatter.date(from: created)
        }
        return nil
    }

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case personalAttributes = "personal_attributes"
        case yarnWeight = "yarn_weight"
        case sizesAvailable = "sizes_available"
        case rating = "rating_average"
        case difficulty = "difficulty_average"
        case needleSizes = "pattern_needle_sizes"
        case author = "pattern_author"
        case ravelryDownload = "ravelry_download"
        case downloadLocation = "download_location"
        case id, name, free, craft, yardage, photos, url, notes, permalink
    }

    init(id: Int?, name: String?, author: Author?, free: Bool = false, craft: Craft?, difficulty: Double? = 0.0, rating: Double? = 3.72, personalAttributes: PersonalAttributes?, yardage: Int?, yarnWeight: YarnWeight?, needleSizes: [NeedleSize]?, sizesAvailable: String?, photos: [Photo]?, createdAt: String?, url: String?, permalink: String?, ravelryDownload: Bool?, downloadLocation: DownloadLocation?, notes: String?) {
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
        self.ravelryDownload = ravelryDownload
        self.downloadLocation = downloadLocation
        self.notes = notes
    }
}

extension Pattern {
    static let mockData = Pattern(id: 688190, name: "Speckled Super Scarf", author: Author.mockData, free: true, craft: Craft.mockData, difficulty: 2.29, personalAttributes: PersonalAttributes.mockData, yardage: 708, yarnWeight: YarnWeight.mockData, needleSizes: [NeedleSize.mockData, NeedleSize.mockData], sizesAvailable: "Scarf measures 10.5” [26.5 cm] wide by 90” [228.5 cm] long.", photos: [Photo.mockData, Photo.mockData, Photo.mockData], createdAt: "2016/09/06 14:58:22 -0400", url: "https://www.yarnspirations.com/row-en/red-heart-speckled-super-scarf/RHC0125-024654M.html", permalink: "speckled-super-scarf", ravelryDownload: true,
                                  downloadLocation: DownloadLocation.mockData, notes: "Simple, but oh so attractive, this over-sized scarf is just what you need to update last year’s wardrobe. Ours is 90” long in a neutral heather, but you can make your Super Scarf any length and any color you desire. This is an easy crochet in a variation of the basic ripple stitch.\r\n\r\nGAUGE: 24 sts (2 ripples) = 7” (18 cm); 5 rows = 4” (10cm) CHECK YOUR GAUGE.\r\n\r\nAlso as [Speckled Super Scarf][1] and [Wavy Ridge][2]\r\n\r\n\r\n  [1]: http://www.redheart.com/free-patterns/speckled-super-scarf\r\n  [2]: https://www.yarnspirations.com/red-heart-wavy-ridge-super-scarf/RHC0125-016921M.html#q=Wavy+ridge&includeContent=true&start=2")
    
    static let emptyData = Pattern(id: nil, name: nil, author: nil, free: false, craft: nil, difficulty: nil, personalAttributes: nil, yardage: nil, yarnWeight: nil, needleSizes: nil, sizesAvailable: nil, photos: nil, createdAt: nil, url: nil, permalink: nil, ravelryDownload: false, downloadLocation: nil, notes: nil)
}
