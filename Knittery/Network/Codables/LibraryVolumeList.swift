//
//  LibraryVolumeList.swift
//  Knittery
//
//  Created by Nick on 2022-12-18.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

struct LibraryVolumeList: Codable {
    let volumes: [LibraryList]?
    
    func getVolumeIdByPatternId(_ patternId: Int?) -> Int? {
        guard let volumes else { return nil }
        
        return volumes.first(where: { $0.patternId == patternId })?.id
    }
}

struct LibraryList: Codable {
    let id: Int?
    let patternId: Int?
    let sourceId: Int?
    
    enum CodingKeys: String, CodingKey {
        case sourceId = "pattern_source_id"
        case patternId = "pattern_id"
        case id
    }
}
