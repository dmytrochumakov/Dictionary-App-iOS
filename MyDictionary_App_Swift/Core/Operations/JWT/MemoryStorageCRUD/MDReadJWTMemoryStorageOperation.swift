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
        guard let jwtResponse = self.memoryStorage.array.first(where: { $0.accessToken == self.accessToken })
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

final class MDReadAllJWTMemoryStorageOperation: MDOperation {
    
    fileprivate let memoryStorage: MDJWTMemoryStorage
    fileprivate let result: MDOperationsResultWithCompletion<JWTResponse>?
    
    init(memoryStorage: MDJWTMemoryStorage,
         result: MDOperationsResultWithCompletion<JWTResponse>?) {
        
        self.memoryStorage = memoryStorage        
        self.result = result
        
        super.init()
    }
    
    override func main() {
        self.result?(.success(self.memoryStorage.array))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
