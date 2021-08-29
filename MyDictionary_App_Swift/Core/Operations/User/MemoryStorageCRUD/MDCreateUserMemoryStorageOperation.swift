//
//  MDCreateUserMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

final class MDCreateUserMemoryStorageOperation: MDOperation {
    
    fileprivate let memoryStorage: MDUserMemoryStorage
    fileprivate let userEntity: UserResponse
    fileprivate let result: MDEntityResult<UserResponse>?
    
    init(memoryStorage: MDUserMemoryStorage,
         userEntity: UserResponse,
         result: MDEntityResult<UserResponse>?) {
        
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
