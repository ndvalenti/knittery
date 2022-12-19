//
//  VolumeAttachments.swift
//  Knittery
//
//  Created by Nick on 2022-12-18.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

struct VolumeAttachments: Codable {
    let attachmentId: Int?
    let ravelryDownload: String?
    let filename: String?
    
    enum CodingKeys: String, CodingKey {
        case attachmentId = "product_attachment_id"
        case ravelryDownload = "ravelry_download_url"
        case filename
    }
}
