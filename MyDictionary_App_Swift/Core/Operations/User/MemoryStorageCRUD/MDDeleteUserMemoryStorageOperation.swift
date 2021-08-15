//
//  MDDeleteUserMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

final class MDDeleteUserMemoryStorageOperation: MDOperation {
    
    fileprivate let memoryStorage: MDUserMemoryStorage
    fileprivate let result: MDUserOperationResult?
    
    init(memoryStorage: MDUserMemoryStorage,
         result: MDUserOperationResult?) {
        
        self.memoryStorage = memoryStorage
        self.result = result
        
        super.init()
        
    }
    
    override func main() {
        guard let userEntity = self.memoryStorage.userEntity
        else {
            self.result?(.failure(MDUserOperationError.cantFindUser));
            self.finish();
            return
        }
        self.memoryStorage.userEntity = nil
        self.result?(.success(userEntity))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
