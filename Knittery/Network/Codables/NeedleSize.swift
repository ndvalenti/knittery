//
//  NeedleSize.swift
//  Knittery
//
//  Created by Nick on 2022-11-16.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation
//TODO: NeedleSize is one of those things we can probably fetch and cache on login

struct NeedleSize: Codable {
    let id: Int?
    let us: String?
    let metric: Double?
    let usSteel: String?
    let crochet: Bool
    let knitting: Bool
    let hook: String?
    let name: String?
    let prettyMetric: String?
    
    var toString: String? {
        name
    }
    
    enum CodingKeys: String, CodingKey {
        case usSteel = "us_steel"
        case prettyMetric = "pretty_metric"
        case id, us, metric, crochet, knitting, hook, name
    }
    
    init(id: Int?, us: String?, metric: Double?, usSteel: String?, crochet: Bool, knitting: Bool, hook: String?, name: String?, prettyMetric: String?) {
        self.id = id
        self.us = us
        self.metric = metric
        self.usSteel = usSteel
        self.crochet = crochet
        self.knitting = knitting
        self.hook = hook
        self.name = name
        self.prettyMetric = prettyMetric
    }
}

extension NeedleSize {
    static let mockData = NeedleSize(id: 11, us: "10.5", metric: 6.5, usSteel: nil, crochet: true, knitting: false, hook: "K", name: "6.5 mm (K)", prettyMetric: "6.5")
}
