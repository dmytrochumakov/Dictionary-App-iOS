//
//  MDCreateUserMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

final class MDCreateUserMemoryStorageOperation: MDOperation {
    
    fileprivate let memoryStorage: MDUserMemoryStorage
    fileprivate var userEntity: UserResponse
    fileprivate let password: String
    fileprivate let result: MDOperationResultWithCompletion<UserResponse>?
    
    init(memoryStorage: MDUserMemoryStorage,
         userEntity: UserResponse,
         password: String,
         result: MDOperationResultWithCompletion<UserResponse>?) {
        
        self.memoryStorage = memoryStorage
        self.userEntity = userEntity
        self.password = password
        self.result = result
        
        super.init()
    }
    
    override func main() {
        self.userEntity.password = self.password
        self.memoryStorage.userEntity = self.userEntity
        self.result?(.success(self.userEntity))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
