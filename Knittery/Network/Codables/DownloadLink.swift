//
//  DownloadLink.swift
//  Knittery
//
//  Created by Nick on 2022-12-18.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

struct DownloadLinkWrapper: Codable {
    let downloadLink: DownloadLink
    
    enum CodingKeys: String, CodingKey {
        case downloadLink = "download_link"
    }
}

struct DownloadLink: Codable {
    let url: String?
    let activated: String?
    let expired: String?
    
    var patternID: Int?
    
    init(_ downloadLink: DownloadLink, patternID: Int? = nil) {
        self.url = downloadLink.url
        self.activated = downloadLink.activated
        self.expired = downloadLink.expired
        
        if patternID == nil {
            self.patternID = downloadLink.patternID
        } else {
            self.patternID = patternID
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case activated = "activated_at"
        case expired = "expired_at"
        case url
    }
}
