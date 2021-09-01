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
    
    var array: [UserResponse]
    
    init(operationQueueService: OperationQueueServiceProtocol,
         array: [UserResponse]) {
        
        self.operationQueueService = operationQueueService
        self.array = array
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDUserMemoryStorage {
    
    func entitiesIsEmpty(_ completionHandler: @escaping (MDEntitiesIsEmptyResultWithCompletion)) {
        readAllUsers { result in
            switch result {
            case .success(let entities):
                completionHandler(.success(entities.isEmpty))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func entitiesCount(_ completionHandler: @escaping (MDEntitiesCountResultWithCompletion)) {
        readAllUsers { result in
            switch result {
            case .success(let entities):
                completionHandler(.success(entities.count))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}

extension MDUserMemoryStorage {
    
    func createUser(_ userEntity: UserResponse,
                    password: String,
                    _ completionHandler: @escaping (MDOperationResultWithCompletion<UserResponse>)) {
        let operation = MDCreateUserMemoryStorageOperation.init(memoryStorage: self,
                                                                userEntity: userEntity,
                                                                password: password) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readUser(fromUserID userId: Int64,
                  _ completionHandler: @escaping (MDOperationResultWithCompletion<UserResponse>)) {
        let operation = MDReadUserMemoryStorageOperation.init(memoryStorage: self,
                                                              userId: userId) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readAllUsers(_ completionHandler: @escaping (MDOperationsResultWithCompletion<UserResponse>)) {
        let operation = MDReadAllUsersMemoryStorageOperation.init(memoryStorage: self) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func deleteUser(_ userId: Int64,
                    _ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        let operation = MDDeleteUserMemoryStorageOperation.init(memoryStorage: self,
                                                                userId: userId) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
}
