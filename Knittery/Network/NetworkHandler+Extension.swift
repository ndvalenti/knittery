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
    
    static func requestPatternById(_ id: String, resultHandler: @escaping (Result<Pattern, ApiError>) -> Void) {
        let request = domain + "patterns/" + id + ".json"
        
        guard let url = URL(string:request) else {
            return
        }
        
        guard let request = URLRequestBuilder(url) else {
            resultHandler(.failure(ApiError.decodeError))  // TODO: make this generic
            return
        }
            
        self.makeRequest(request) { (result: Result<PatternWrapper, ApiError>) in
            switch(result) {
            case .success(let patternWrapper):
                resultHandler(.success(patternWrapper.pattern))
            case .failure(let error):
                resultHandler(.failure(error))
            }
        }
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
    
    static private func makeRequest<T: Codable>(_ request: URLRequest, resultHandler: @escaping (Result<T, ApiError>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
            
            guard let r = response as? HTTPURLResponse, 200...299 ~= r.statusCode else {
                print(response.debugDescription)
                return
            }
            
            guard let data = data else {
                print("no data")
                return
            }
            
            // will send a second request and dump the response to console, not ideal
//            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
//                return
//            }
//            print("JSON:", json)
            
            
            guard let decoded:T = self.decodedData(data) else {
                resultHandler(.failure(.decodeError))
                return
            }
            
            resultHandler(.success(decoded))
        }
        task.resume()
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
