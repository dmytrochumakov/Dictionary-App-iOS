//
//  MDUserMemoryStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

protocol MDUserMemoryStorageProtocol: MDCRUDUserProtocol,
                                      MDStorageInterface {
    
}

final class MDUserMemoryStorage: MDUserMemoryStorageProtocol {
    
    fileprivate let operationQueueService: OperationQueueServiceProtocol
    
    var userEntity: UserResponse?
    
    init(operationQueueService: OperationQueueServiceProtocol,
         userEntity: UserResponse?) {
        
        self.operationQueueService = operationQueueService
        self.userEntity = userEntity
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDUserMemoryStorage {
    
    func entitiesIsEmpty(_ completionHandler: @escaping (MDEntitiesIsEmptyResultWithCompletion)) {
        if (userEntity == nil) {
            completionHandler(.success(true))
        } else {
            completionHandler(.success(false))
        }
    }
    
    func entitiesCount(_ completionHandler: @escaping (MDEntitiesCountResultWithCompletion)) {
        if (userEntity == nil) {
            completionHandler(.success(0))
        } else {
            completionHandler(.success(1))
        }
    }
    
}

extension MDUserMemoryStorage {
    
    func createUser(_ userEntity: UserResponse,
                    password: String,
                    _ completionHandler: @escaping (MDEntityResult<UserResponse>)) {
        let operation = MDCreateUserMemoryStorageOperation.init(memoryStorage: self,
                                                                userEntity: userEntity,
                                                                password: password) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readUser(fromUserID userId: Int64,
                  _ completionHandler: @escaping (MDEntityResult<UserResponse>)) {
        let operation = MDReadUserMemoryStorageOperation.init(memoryStorage: self,
                                                              userId: userId) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func deleteUser(_ userEntity: UserResponse,
                    _ completionHandler: @escaping (MDEntityResult<UserResponse>)) {
        let operation = MDDeleteUserMemoryStorageOperation.init(memoryStorage: self,
                                                                userEntity: userEntity) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
}
