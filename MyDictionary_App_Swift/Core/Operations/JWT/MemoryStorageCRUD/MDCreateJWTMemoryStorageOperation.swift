//
//  MDCreateJWTMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

final class MDCreateJWTMemoryStorageOperation: MDOperation {
    
    fileprivate let memoryStorage: MDJWTMemoryStorage
    fileprivate let jwtResponse: JWTResponse
    fileprivate let result: MDOperationResultWithCompletion<JWTResponse>?
    
    init(memoryStorage: MDJWTMemoryStorage,
         jwtResponse: JWTResponse,
         result: MDOperationResultWithCompletion<JWTResponse>?) {
        
        self.memoryStorage = memoryStorage
        self.jwtResponse = jwtResponse
        self.result = result
        
        super.init()
    }
    
    override func main() {
        self.memoryStorage.jwtResponse = self.jwtResponse
        self.result?(.success(self.jwtResponse))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
