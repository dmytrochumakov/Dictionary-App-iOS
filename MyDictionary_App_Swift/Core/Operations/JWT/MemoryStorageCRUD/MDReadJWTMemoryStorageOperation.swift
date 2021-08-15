//
//  MDReadJWTMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

final class MDReadJWTMemoryStorageOperation: MDOperation {
    
    fileprivate let memoryStorage: MDJWTMemoryStorage
    fileprivate let accessToken: String
    fileprivate let result: MDEntityResult<AuthResponse>?
    
    init(memoryStorage: MDJWTMemoryStorage,
         accessToken: String,
         result: MDEntityResult<AuthResponse>?) {
        
        self.memoryStorage = memoryStorage
        self.accessToken = accessToken
        self.result = result
        
        super.init()
    }
    
    override func main() {
        guard let authResponse = self.memoryStorage.authResponse,
              authResponse.accessToken == self.accessToken
        else {
            self.result?(.failure(MDEntityOperationError.cantFindEntity));
            self.finish();
            return
        }
        self.result?(.success(authResponse))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
