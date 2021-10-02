//
//  MDReadFirstJWTMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.08.2021.
//

import Foundation

final class MDReadFirstJWTMemoryStorageOperation: MDAsyncOperation {
    
    fileprivate let memoryStorage: MDJWTMemoryStorage
    fileprivate let result: MDOperationResultWithCompletion<JWTResponse>?
    
    init(memoryStorage: MDJWTMemoryStorage,
         result: MDOperationResultWithCompletion<JWTResponse>?) {
        
        self.memoryStorage = memoryStorage
        self.result = result
        
        super.init()
    }
    
    override func main() {
        guard let jwtResponse = self.memoryStorage.array.first
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
