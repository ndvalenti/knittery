//
//  ErrorTypes.swift
//  Knittery
//
//  Created by Nick on 2022-10-03.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

enum ApiError: Error, CustomStringConvertible {
    case decodeError
    case invalidUrl
    case noData
    case invalidResponse
    
    public var description: String {
        switch self {
        case .decodeError:
            return "Error decoding API"
        case .invalidUrl:
            return "Invalid URL"
        case .noData:
            return "No data"
        case .invalidResponse:
            return "Invalid HTTP response code"
        }
    }
}
