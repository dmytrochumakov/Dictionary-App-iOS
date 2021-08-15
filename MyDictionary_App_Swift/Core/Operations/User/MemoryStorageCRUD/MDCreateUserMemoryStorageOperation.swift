//
//  MDCreateUserMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

final class MDCreateUserMemoryStorageOperation: MDOperation {
    
    fileprivate let memoryStorage: MDUserMemoryStorage
    fileprivate let userEntity: UserEntity
    fileprivate let result: MDUserOperationResult?
    
    init(memoryStorage: MDUserMemoryStorage,
         userEntity: UserEntity,
         result: MDUserOperationResult?) {
        
        self.memoryStorage = memoryStorage
        self.userEntity = userEntity
        self.result = result
        
        super.init()
    }
    
    override func main() {
        self.memoryStorage.userEntity = self.userEntity
        self.result?(.success(self.userEntity))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
