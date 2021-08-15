//
//  MDDeleteUserMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

final class MDDeleteUserMemoryStorageOperation: MDOperation {
    
    fileprivate let memoryStorage: MDUserMemoryStorage
    fileprivate let userEntity: UserEntity
    fileprivate let result: MDEntityResult<UserEntity>?
    
    init(memoryStorage: MDUserMemoryStorage,
         userEntity: UserEntity,
         result: MDEntityResult<UserEntity>?) {
        
        self.memoryStorage = memoryStorage
        self.userEntity = userEntity
        self.result = result
        
        super.init()
        
    }
    
    override func main() {
        guard let userEntity = self.memoryStorage.userEntity,
              userEntity.userId == self.userEntity.userId
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
