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

enum QueryError: Error, CustomStringConvertible {
    case invalidQuery
    
    public var description: String {
        switch self {
        case .invalidQuery:
            return "Invalid Query Parameter"
        }
    }
}

enum KeychainError: Error, CustomStringConvertible {
    case noToken
    case incorrectDataType
    
    public var description: String {
        switch self {
        case .noToken:
            return "No token stored"
        case .incorrectDataType:
            return "Could not convert Data to String?"
        }
    }
}
