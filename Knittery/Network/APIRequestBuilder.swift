//
//  APIRequestBuilder.swift
//  Knittery
//
//  Created by Nick on 2022-09-29.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

extension NetworkHandler {
    static private let domain = "https://api.ravelry.com/"
    
    static func buildPatternRequestById(_ id: Int) -> URLRequest? {
        return buildPatternRequestById(String(id))
    }
    
    static func buildPatternRequestById(_ id: String) -> URLRequest? {
        let request = domain + "patterns/" + id + ".json"
        let url = URL(string: request)
        return URLRequestBuilder(url!)
    }
    
    static private func URLRequestBuilder(_ url: URL) -> URLRequest? {
        var request = URLRequest(url: url)
        guard let token = KeychainHandler.readToken(type: .access) else {
            print("Could not get access token")
            return nil
        }
        let responseToken = "Bearer: \(token)"
        request.addValue(responseToken, forHTTPHeaderField: "Authorization")
        return request
    }
    
    static private func decodedData<T: Codable>(_ data: Data) -> T? {
        do {
            let decode = try JSONDecoder().decode(T.self, from: data)
            return decode
        } catch let error {
            print(error)
            return nil
        }
    }
}
