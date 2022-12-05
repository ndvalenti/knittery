//
//  YarnWeight.swift
//  Knittery
//
//  Created by Nick on 2022-11-16.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

struct YarnWeight: Codable {
    let id: Int?
    let crochetGauge: String?
    let knitGauge: String?
    let name: String?
    let ply: String?
    let wpi: String?
    
    var toString: String? {
        if name != nil && wpi != nil {
            return ("\(name!) (\(wpi!) wpi)")
        } else { return nil }
    }
    
    enum CodingKeys: String, CodingKey {
        case crochetGauge = "crochet_gauge"
        case knitGauge = "knit_gauge"
        case id, name, ply, wpi
    }
    
    init(id: Int?, crochetGauge: String?, knitGauge: String?, name: String?, ply: String?, wpi: String?) {
        self.id = id
        self.crochetGauge = crochetGauge
        self.knitGauge = knitGauge
        self.name = name
        self.ply = ply
        self.wpi = wpi
    }
}

extension YarnWeight {
    static let mockData = YarnWeight(id: 1, crochetGauge: "", knitGauge: "18", name: "Aran", ply: "10", wpi: "8")
    static let emptyData = YarnWeight(id: nil, crochetGauge: nil, knitGauge: nil, name: nil, ply: nil, wpi: nil)
}
