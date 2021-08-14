//
//  KeychainService.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 14.08.2021.
//

import Foundation

struct KeychainService {
    
    func savePassword(_ string: String, for account: String) {
        let data = string.data(using: .utf8)!
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: account,
                                    kSecValueData as String: data]
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { return debugPrint(#function, Self.self, "save error") }
    }
    
    func retrivePassword(for account: String) -> String? {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: account,
                                    kSecMatchLimit as String: kSecMatchLimitOne,
                                    kSecReturnData as String: kCFBooleanTrue]
        
        
        var retrivedData: AnyObject? = nil
        let _ = SecItemCopyMatching(query as CFDictionary, &retrivedData)
        
        
        guard let data = retrivedData as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    func deletePassword(for account: String) {
        let query: [String: AnyObject] = [
            // uniquely identify the item to delete in Keychain
            kSecAttrAccount as String: account as AnyObject,
            kSecClass as String: kSecClassGenericPassword
        ]
        
        // SecItemDelete attempts to perform a delete operation
        // for the item identified by query. The status indicates
        // if the operation succeeded or failed.
        let status = SecItemDelete(query as CFDictionary)
        
        // Any status other than errSecSuccess indicates the
        // delete operation failed.
        guard status == errSecSuccess else { return debugPrint(#function, Self.self, "delete error") }
    }
    
}
