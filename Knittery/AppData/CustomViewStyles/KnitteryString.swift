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
    static let lipsum =  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Maecenas accumsan lacus vel facilisis volutpat est velit egestas dui. Id aliquet lectus proin nibh nisl condimentum id venenatis. Condimentum lacinia quis vel eros donec ac odio tempor. Ultrices tincidunt arcu non sodales neque sodales ut etiam sit. Tellus id interdum velit laoreet. Egestas quis ipsum suspendisse ultrices gravida. Purus faucibus ornare suspendisse sed nisi lacus sed. Et odio pellentesque diam volutpat. Donec pretium vulputate sapien nec sagittis.Tincidunt augue interdum velit euismod. Erat velit scelerisque in dictum non consectetur a erat nam. Purus in massa tempor nec feugiat nisl."
}
