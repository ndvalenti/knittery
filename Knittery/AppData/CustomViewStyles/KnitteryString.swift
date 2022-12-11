//
//  KnitteryString.swift
//  Knittery
//
//  Created by Nick on 2022-12-11.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

extension String {
    static func placeholder(length: Int) -> String {
        String(Array(repeating: "A", count: length))
    }
}
