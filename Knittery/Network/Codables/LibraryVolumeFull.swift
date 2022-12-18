//
//  LibraryVolumeFull.swift
//  Knittery
//
//  Created by Nick on 2022-12-18.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

struct LibraryVolumeFullWrapper: Codable {
    let volume: LibraryVolumeFull
}

struct LibraryVolumeFull: Codable {
    let id: Int?
    let attachments: [VolumeAttachments]?
    
    enum CodingKeys: String, CodingKey {
        case attachments = "volume_attachments"
        case id
    }
}
