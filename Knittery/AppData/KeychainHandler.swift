//
//  KeychainHandler.swift
//  Knittery
//
//  Created by Nick on 2022-09-27.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import Foundation

class KeychainHandler {
    enum TokenType: String {
        case access = "access-token"
        case refresh = "refresh-token"
        case library = "library-token"
    }
    
    static func saveToken(_ token: String, type: TokenType) {
        let data = Data(token.utf8)
        self.saveDataToKeychain(data, service: type.rawValue, account: "ravelry")
    }
    
    static func readToken(_ type: TokenType) -> String? {
        guard let tokenData = self.readDataFromKeychain(type.rawValue, account: "ravelry") else {
            print("Error: \(KeychainError.noToken)")
            return nil
        }
        
        guard let accessToken = String(data: tokenData, encoding: .utf8) else {
            print("Error: \(KeychainError.incorrectDataType)")
            return nil
        }
        
        return accessToken
    }
    
    static func deleteToken(_ type: TokenType) {
        deleteItemFromKeychain(type.rawValue, account: "ravelry")
    }
    
    static private func saveDataToKeychain(_ data: Data, service: String, account: String) {
        let addQuery = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary
        
        let status = SecItemAdd(addQuery, nil)
        
        if status != errSecSuccess {
            if status == errSecDuplicateItem {
                let updateQuery = [
                    kSecAttrService: service,
                    kSecAttrAccount: account,
                    kSecClass: kSecClassGenericPassword,
                ] as CFDictionary
                
                let attributesToUpdate = [kSecValueData: data] as CFDictionary
                SecItemUpdate(updateQuery, attributesToUpdate)
            } else {
                print("Error: \(status)")
            }
        }
    }
    
    static private func readDataFromKeychain(_ service: String, account: String) -> Data? {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return (result as? Data)
    }
    
    static private func deleteItemFromKeychain(_ service: String, account: String) {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        SecItemDelete(query)
    }
}
