//
//  MDDeleteJWTMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

final class MDDeleteJWTMemoryStorageOperation: MDOperation {
    
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
        guard let jwtResponse = self.memoryStorage.jwtResponse,
              jwtResponse.accessToken == self.jwtResponse.accessToken
        else {
            self.result?(.failure(MDEntityOperationError.cantFindEntity));
            self.finish();
            return
        }
        self.memoryStorage.jwtResponse = nil
        self.result?(.success(jwtResponse))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
