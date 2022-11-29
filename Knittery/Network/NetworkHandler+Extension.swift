//
//  APIRequestBuilder.swift
//  Knittery
//
//  Created by Nick on 2022-09-29.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation
import UIKit

extension NetworkHandler {
    static private let domain = "https://api.ravelry.com/"
    
    static func requestPatternById(_ id: Int, resultHandler: @escaping (Result<Pattern, ApiError>) -> Void) {
        let apicall = domain + "patterns/" + String(id) + ".json"
        
        guard let url = URL(string: apicall) else {
            resultHandler(.failure(ApiError.invalidUrl))
            return
        }
        
        guard let request = URLRequestBuilder(url) else {
            resultHandler(.failure(ApiError.invalidUrl))
            return
        }
            
        self.makeRequest(request) { (result: Result<PatternWrapper, ApiError>) in
            switch(result) {
            case .success(let patternWrapper):
                if let pattern = patternWrapper.pattern {
                    resultHandler(.success(pattern))
                }
            case .failure(let error):
                resultHandler(.failure(error))
            }
        }
    }
    
    // yarns have fewer search options
    // TODO: Look into URLComponents and see if we can't work with URL? queries rathar than String? for a more pure experience
    // https://cocoacasts.com/working-with-nsurlcomponents-in-swift
    static func requestPatternSearch(query: String, resultHandler: @escaping (Result<PatternSearch, ApiError>) -> Void) {
//        let apicall = domain + "patterns/search.json?craft=crochet%7Cknitting&query=dark%20matter%20shawl"
        let apicall = domain + "patterns/search.json" + query
        guard let url = URL(string: apicall) else {
            resultHandler(.failure(ApiError.invalidUrl))
            return
        }
        guard let request = URLRequestBuilder(url) else {
            resultHandler(.failure(ApiError.invalidUrl))
            return
        }
        self.makeRequest(request) { (result: Result<PatternSearch, ApiError>) in
            switch(result) {
            case .success(let search):
                resultHandler(.success(search))
            case .failure(let error):
                resultHandler(.failure(error))
            }
        }
    }
    
    static func requestCurrentUser(resultHandler: @escaping (Result<User, ApiError>) -> Void) {
        let request = domain + "current_user.json"
        
        guard let url = URL(string:request) else {
            resultHandler(.failure(ApiError.invalidUrl))
            return
        }
        
        guard let request = URLRequestBuilder(url) else {
            resultHandler(.failure(ApiError.invalidUrl))
            return
        }
        
        self.makeRequest(request) { (result: Result<UserWrapper, ApiError>) in
            switch(result) {
            case .success(let user):
                if let user = user.user {
                    resultHandler(.success(user))
                }
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
                resultHandler(.failure(.invalidResponse))
                print(response.debugDescription)
                return
            }
            
            guard let data = data else {
                resultHandler(.failure(.noData))
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
    
    static func loadImageFrom(url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
