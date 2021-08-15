//
//  MDReadUserMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

final class MDReadUserMemoryStorageOperation: MDOperation {
    
    fileprivate let memoryStorage: MDUserMemoryStorage
    fileprivate let userId: Int64
    fileprivate let result: MDEntityResult<UserEntity>?
    
    init(memoryStorage: MDUserMemoryStorage,
         userId: Int64,
         result: MDEntityResult<UserEntity>?) {
        
        self.memoryStorage = memoryStorage
        self.userId = userId
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
        self.result?(.success(userEntity))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
