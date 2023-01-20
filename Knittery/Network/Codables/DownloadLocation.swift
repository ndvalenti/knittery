//
//  DownloadLocation.swift
//  Knittery
//
//  Created by Nick on 2022-11-23.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

struct DownloadLocation: Codable {
    let type: String?
    let free: Bool?
    let url: String?
    
    init(type: String?, free: Bool?, url: String?) {
        self.type = type
        self.free = free
        self.url = url
    }
}

extension DownloadLocation {
    static let mockData = DownloadLocation(type: "ravelry", free: false, url: "http://www.ravelry.com/purchase/daniela-muhlbauer-designs/819634")
    static let emptyData = DownloadLocation(type: nil, free: nil, url: nil)
}
