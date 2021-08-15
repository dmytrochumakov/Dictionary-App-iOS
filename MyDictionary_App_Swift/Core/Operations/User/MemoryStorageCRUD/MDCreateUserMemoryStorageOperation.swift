//
//  MDCreateUserMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

final class MDCreateUserMemoryStorageOperation: MDOperation {
    
    fileprivate let wordStorage: MDUserMemoryStorage
    fileprivate let userEntity: UserEntity
    fileprivate let result: MDUserOperationResult?
    
    init(wordStorage: MDUserMemoryStorage,
         userEntity: UserEntity,
         result: MDUserOperationResult?) {
        
        self.wordStorage = wordStorage
        self.userEntity = userEntity
        self.result = result
        
        super.init()
    }
    
    override func main() {
        self.wordStorage.userEntity = self.userEntity
        self.result?(.success(self.userEntity))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
