//
//  KeyChainManager.swift
//  CommitGenerator
//
//  Created by 박종호 on 2022/02/28.
//

import Foundation

final class KeyChainManager {
    static let shared = KeyChainManager()
    
    private init(){}
    
    private let account = "accessToken"
    private let service = Bundle.main.bundleIdentifier
    
    func saveToken(_ token : String) -> Bool {
        guard let data = try? JSONEncoder().encode(token), let service = self.service else {
            return false
        }
        
        let query : [CFString : Any] = [kSecClass : kSecClassGenericPassword,
                                  kSecAttrService : service,
                                  kSecAttrAccount : account,
                                  kSecAttrGeneric : data]
        
        return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
    }
    
    func readToken() -> String? {
        guard let service = service else {
            return nil
        }
        
        let query : [CFString : Any] = [kSecClass : kSecClassGenericPassword,
                                  kSecAttrService : service,
                                  kSecAttrAccount : account,
                                   kSecMatchLimit : kSecMatchLimitOne,
                             kSecReturnAttributes : true,
                                   kSecReturnData : true]
        
        var item : CFTypeRef?
        if SecItemCopyMatching(query as CFDictionary, &item) != errSecSuccess {
            return nil
        }
        
        guard let existingItem = item as? [String : Any],
              let data = existingItem[kSecAttrGeneric as String] as? Data,
              let token = try? JSONDecoder().decode(String.self, from: data) else {
                  return nil
              }
        return token

    }
    
    func deleteToken() -> Bool{
        let deleteQuery : [CFString : Any] = [kSecClass : kSecClassGenericPassword,
                                        kSecAttrAccount : account]
        return SecItemDelete(deleteQuery as CFDictionary) == errSecSuccess
    }
    
    func updateToken(_ token : String) -> Bool {
        let previousQuery : [CFString : Any] = [kSecClass : kSecClassGenericPassword, kSecAttrAccount : account]
        let query : [CFString : Any] = [kSecValueData : token]
        return SecItemUpdate(previousQuery as CFDictionary, query as CFDictionary) == errSecSuccess
        
    }
}
