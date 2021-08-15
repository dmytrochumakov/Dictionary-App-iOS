//
//  MDDeleteJWTMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

final class MDDeleteJWTMemoryStorageOperation: MDOperation {
    
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
        guard let authResponse = self.memoryStorage.authResponse,
              authResponse.accessToken == self.authResponse.accessToken
        else {
            self.result?(.failure(MDEntityOperationError.cantFindEntity));
            self.finish();
            return
        }
        self.memoryStorage.authResponse = nil
        self.result?(.success(authResponse))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
