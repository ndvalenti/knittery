//
//  NetworkHandler.swift
//  Knittery
//
//  Created by Nicholas Valenti on 2022-09-23.
//

import Foundation
import OAuthSwift
import AuthenticationServices

import Security

class NetworkHandler: NSObject, ObservableObject, ASWebAuthenticationPresentationContextProviding {
    var oauthswift: OAuth2Swift!
    
    @Published var sessionData = SessionData()
    
    override init () {
        super.init()
        oauthswift = OAuth2Swift(
            consumerKey:    APIKeys.RavelryOAuth.consumerKey.rawValue,
            consumerSecret: APIKeys.RavelryOAuth.consumerSecret.rawValue,
            authorizeUrl:   "https://www.ravelry.com/oauth2/auth",
            accessTokenUrl: "https://www.ravelry.com/oauth2/token",
            responseType:   "code"
        )
    }
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    func signIn(completion: @escaping (Bool) -> Void) {
        oauthswift.authorizeURLHandler = ASWebAuthenticationURLHandler(
            callbackUrlScheme: "knitteryapp",
            presentationContextProvider: self
        )
        
        let state = generateState(withLength: 20)
        
//        let loginString = String(format: "%@:%@",
//                                 oauthswift.client.credential.consumerKey,
//                                 oauthswift.client.credential.consumerSecret)
//        let loginData = loginString.data(using: String.Encoding.utf8)!
//        let base64LoginString = loginData.base64EncodedString()
//        let header = ["Authorization":"Basic \(base64LoginString)"]
        
        oauthswift.client.credential.headersFactory = XHeaders(credential: oauthswift.client.credential)
//        oauthswift.allowMissingStateCheck = true
        
        // authorize has a headers: argument if we can construct out headers outside the factory
        // we only use the headers factory once and can build them in place IF we don't need it for
        // refresh tokens
        let _ = oauthswift.authorize(
            withCallbackURL: "knitteryapp://oauth-callback",
            scope: "offline",
            state: state) { result in
                switch result {
                case .success(let (credential, _, _)):
                    KeychainHandler.saveToken(credential.oauthToken, type: .access)
                    KeychainHandler.saveToken(credential.oauthRefreshToken, type: .refresh)
                    completion(true)
                case .failure(let error):
                    print(error.description)
                    completion(false)
                }
            }
    }
    
    // todo: use debugger to track how headers are constructed for refresh tokens, might be able to do away with the entire factory if it follows the access token path
    func refreshAccessToken(completion: @escaping (Bool) -> Void) {
        if let refreshToken = KeychainHandler.readToken(type: .refresh) {
            oauthswift.client.credential.headersFactory = XHeaders(credential: oauthswift.client.credential)
            oauthswift.renewAccessToken(withRefreshToken: refreshToken) { result in
                switch result {
                case .success(let (credential, _, _)):
                    KeychainHandler.saveToken(credential.oauthToken, type: .access)
                    KeychainHandler.saveToken(credential.oauthRefreshToken, type: .refresh)
                    completion(true)
                case .failure(let error):
                    print(error.description)
                    completion(false)
                }
            }
        }
    }

    static func makeRequest<T: Codable>(_ request: URLRequest, debug: Bool = false, resultHandler: @escaping (Result<T, ApiError>) -> Void) {
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
            
            // debug will send a second request and dump the response to console, not ideal
            if debug {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    return
                }
                print("JSON:", json)
            }
            
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

// Ravelry only supports auth headers using "Authorization: " pattern and not body auth
class XHeaders: OAuthSwiftCredentialHeadersFactory {
    let credential: OAuthSwiftCredential
    
    init(credential: OAuthSwiftCredential) {
        self.credential = credential
    }
    
    func make(_ url: URL,
              method: OAuthSwiftHTTPRequest.Method,
              parameters: OAuthSwift.Parameters,
              body: Data?) -> [String: String] {
        if credential.oauthToken.isEmpty {
            let loginString = String(format: "%@:%@", credential.consumerKey, credential.consumerSecret)
            let loginData = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString = loginData.base64EncodedString()
            
            return ["Authorization":"Basic \(base64LoginString)"]
        }
        return ["Authorization":"Bearer \(credential.oauthToken)"]
    }
}
