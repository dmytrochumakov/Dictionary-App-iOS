//
//  MDSession.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 14.08.2021.
//

import Foundation

protocol MDSessionProtocol {
    var user: UserEntity? { get }
    var userPassword: String? { get }
    func logout()
}

struct MDSession: MDSessionProtocol {
    
    fileprivate let keychainService: KeychainService
    
    init(keychainService: KeychainService) {
        self.keychainService = keychainService
    }
    
    var user: UserEntity? {
        return nil
    }
    
    var userPassword: String? {
        guard let nickname = self.user?.nickname else { debugPrint(#function, Self.self, "ERROR! nickname is nil"); return nil }
        return keychainService.retrivePassword(for: nickname)
    }
    
}

extension MDSession {
    
    func logout() {
        guard let nickname = self.user?.nickname else { debugPrint(#function, Self.self, "ERROR! nickname is nil"); return }
        keychainService.deletePassword(for: nickname)
    }
    
}
