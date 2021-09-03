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
        guard let userEntity = self.memoryStorage.array.first(where: { $0.userId == userId })              
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

final class MDReadFirstUserMemoryStorageOperation: MDOperation {
    
    fileprivate let memoryStorage: MDUserMemoryStorage
    fileprivate let result: MDOperationResultWithCompletion<UserResponse>?
    
    init(memoryStorage: MDUserMemoryStorage,
         result: MDOperationResultWithCompletion<UserResponse>?) {
        
        self.memoryStorage = memoryStorage
        self.result = result
        
        super.init()
    }
    
    override func main() {
        guard let userEntity = self.memoryStorage.array.first
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

final class MDReadAllUsersMemoryStorageOperation: MDOperation {
    
    fileprivate let memoryStorage: MDUserMemoryStorage
    fileprivate let result: MDOperationsResultWithCompletion<UserResponse>?
    
    init(memoryStorage: MDUserMemoryStorage,
         result: MDOperationsResultWithCompletion<UserResponse>?) {
        
        self.memoryStorage = memoryStorage
        self.result = result
        
        super.init()
    }
    
    override func main() {
        self.result?(.success(memoryStorage.array))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
