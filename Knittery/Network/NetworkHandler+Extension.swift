//
//  APIRequestBuilder.swift
//  Knittery
//
//  Created by Nick on 2022-09-29.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation
import Combine
import UIKit

extension NetworkHandler {
    static private let domain = "https://api.ravelry.com/"

    // yarns have fewer search options
    // TODO: Look into URLComponents and see if we can't work with URL? queries rathar than String? for a more pure experience
    // https://cocoacasts.com/working-with-nsurlcomponents-in-swift
    static func requestPatternSearch(query: String) -> AnyPublisher<PatternSearch, Error> {
        let apicall = domain + "patterns/search.json" + query
        return execute(apicall)
    }

    static func requestPatternById(_ id: Int) -> AnyPublisher<Pattern, Error> {
        let apicall = domain + "patterns/" + String(id) + ".json"
        return execute(apicall)
            .compactMap { (wrapper: PatternWrapper) -> Pattern? in
                wrapper.pattern
            }
            .eraseToAnyPublisher()
    }

    static func requestCurrentUser() -> AnyPublisher<User, Error> {
        let apicall = domain + "current_user.json"
        return execute(apicall)
            .compactMap { (wrapper: UserWrapper) -> User? in
                wrapper.user
            }
            .eraseToAnyPublisher()
    }

    static func addFavorite(patternId: String, username: String) -> AnyPublisher<Bookmark, Error> {
        let dataModel = Favorite(id: patternId, type: "pattern", comment: "")
        let apicall = domain + "people/\(username)/favorites/create.json"
        guard let model = dataModel.jsonData else {
            return Fail(error: ApiError.encodeError).eraseToAnyPublisher()
        }
        guard let url = URL(string: apicall),
              var request = URLRequestBuilder(url) else {
            return Fail(error: ApiError.invalidUrl).eraseToAnyPublisher()
        }
        request.httpMethod = "POST"
        request.httpBody = model

        return execute(request)
            .compactMap { (wrapper: BookmarkWrapper) -> Bookmark? in
                wrapper.bookmark
            }
            .eraseToAnyPublisher()
    }

    static func deleteFavorite(bookmarkId: String, username: String) -> AnyPublisher<Bookmark, Error> {
        let apicall = domain + "people/\(username)/favorites/\(bookmarkId).json"
        return execute(apicall, httpMethod: "DELETE")
            .compactMap { (wrapper: BookmarkWrapper) -> Bookmark? in
                wrapper.bookmark
            }
            .eraseToAnyPublisher()
    }
}

extension NetworkHandler {

    private static func execute<T>(_ urlString: String, httpMethod: String = "GET") -> AnyPublisher<T, Error> where T: Decodable {
        guard let url = URL(string: urlString),
              var request = URLRequestBuilder(url) else {
            return Fail(error: ApiError.invalidUrl).eraseToAnyPublisher()
        }
        request.httpMethod = httpMethod
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    private static func execute<T>(_ request: URLRequest) -> AnyPublisher<T, Error> where T: Decodable {
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    static private func URLRequestBuilder(_ url: URL) -> URLRequest? {
        var request = URLRequest(url: url)
        guard let token = KeychainHandler.readToken(.access) else {
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
