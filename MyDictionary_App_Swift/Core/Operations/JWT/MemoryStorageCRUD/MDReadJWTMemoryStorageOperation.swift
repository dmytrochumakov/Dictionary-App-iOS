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
    fileprivate let result: MDOperationResultWithCompletion<JWTResponse>?
    
    init(memoryStorage: MDJWTMemoryStorage,
         accessToken: String,
         result: MDOperationResultWithCompletion<JWTResponse>?) {
        
        self.memoryStorage = memoryStorage
        self.accessToken = accessToken
        self.result = result
        
        super.init()
    }
    
    override func main() {
        guard let jwtResponse = self.memoryStorage.jwtResponse,
              jwtResponse.accessToken == self.accessToken
        else {
            self.result?(.failure(MDEntityOperationError.cantFindEntity));
            self.finish();
            return
        }
        self.result?(.success(jwtResponse))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
