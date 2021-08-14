//
//  KeychainService_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 14.08.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class KeychainService_Tests: XCTestCase {
    
    fileprivate let account_For_Test: String = "Account"
    fileprivate let password_For_Test: String = "Password"
    
    fileprivate var keychainService: KeychainService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
                
        self.keychainService = KeychainService.init()
        
    }
    
}

extension KeychainService_Tests {
     
    func test_Save_Password() {
        keychainService.savePassword(password_For_Test, for: account_For_Test)
        let savedPassword = keychainService.retrivePassword(for: account_For_Test)
        XCTAssertTrue(savedPassword != nil)
    }
    
    func test_Retrive_Password() {
        keychainService.savePassword(password_For_Test, for: account_For_Test)
        let savedPassword = keychainService.retrivePassword(for: account_For_Test)
        XCTAssertTrue(savedPassword == password_For_Test)
    }
    
    func test_Delete_Password() {
        keychainService.savePassword(password_For_Test, for: account_For_Test)
        keychainService.deletePassword(for: account_For_Test)
        let savedPassword = keychainService.retrivePassword(for: account_For_Test)
        XCTAssertTrue(savedPassword == nil)
    }
    
}
