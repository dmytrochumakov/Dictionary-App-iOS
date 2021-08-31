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
    fileprivate let result: MDOperationResultWithCompletion<UserResponse>?
    
    init(memoryStorage: MDUserMemoryStorage,
         userId: Int64,
         result: MDOperationResultWithCompletion<UserResponse>?) {
        
        self.memoryStorage = memoryStorage
        self.userId = userId
        self.result = result
        
        super.init()
    }
    
    override func main() {
        guard let userEntity = self.memoryStorage.userEntity,
              userEntity.userId == self.userId
        else {
            self.result?(.failure(MDEntityOperationError.cantFindEntity));
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
