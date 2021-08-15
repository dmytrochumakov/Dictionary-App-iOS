//
//  MDCreateJWTMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

final class MDCreateJWTMemoryStorageOperation: MDOperation {
    
    fileprivate let memoryStorage: MDJWTMemoryStorage
    fileprivate let authResponse: AuthResponse
    fileprivate let result: MDEntityResult<AuthResponse>?
    
    init(memoryStorage: MDJWTMemoryStorage,
         authResponse: AuthResponse,
         result: MDEntityResult<AuthResponse>?) {
        
        self.memoryStorage = memoryStorage
        self.authResponse = authResponse
        self.result = result
        
        super.init()
    }
    
    override func main() {
        self.memoryStorage.authResponse = self.authResponse
        self.result?(.success(self.authResponse))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
