//
//  MDDeleteAllJWTMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

final class MDDeleteAllJWTMemoryStorageOperation: MDOperation {
    
    fileprivate let memoryStorage: MDJWTMemoryStorage
    fileprivate let result: MDOperationResultWithCompletion<Void>?
    
    init(memoryStorage: MDJWTMemoryStorage,
         result: MDOperationResultWithCompletion<Void>?) {
        
        self.memoryStorage = memoryStorage
        self.result = result
        
        super.init()
        
    }
    
    override func main() {
        guard let _ = self.memoryStorage.jwtResponse
        else {
            self.result?(.failure(MDEntityOperationError.cantFindEntity));
            self.finish();
            return
        }
        self.memoryStorage.jwtResponse = nil
        self.result?(.success(()))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
