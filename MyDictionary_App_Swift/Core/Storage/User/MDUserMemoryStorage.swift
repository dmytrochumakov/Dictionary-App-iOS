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
    
    fileprivate let operationQueue: OperationQueue
    
    var array: [UserResponse]
    
    init(operationQueue: OperationQueue,
         array: [UserResponse]) {
        
        self.operationQueue = operationQueue
        self.array = array
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Entities
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

// MARK: - Create
extension MDUserMemoryStorage {
    
    func createUser(_ userEntity: UserResponse,
                    password: String,
                    _ completionHandler: @escaping (MDOperationResultWithCompletion<UserResponse>)) {
        
        let operation: BlockOperation = .init {
            
            var copiedUserEntity = userEntity
            copiedUserEntity.password = password
            
            self.array.append(copiedUserEntity)
            
            completionHandler(.success(copiedUserEntity))
            
            //
            return
            //
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
}

// MARK: - Read
extension MDUserMemoryStorage {
    
    func readUser(fromUserID userId: Int64,
                  _ completionHandler: @escaping (MDOperationResultWithCompletion<UserResponse>)) {
        
        let operation: BlockOperation = .init {
            
            guard let userEntity = self.array.first(where: { $0.userId == userId })
            else {
                
                //
                completionHandler(.failure(MDEntityOperationError.cantFindEntity));
                //
                
                //
                return
                //
                
            }
            
            completionHandler(.success(userEntity))
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
    func readFirstUser(_ completionHandler: @escaping (MDOperationResultWithCompletion<UserResponse>)) {
        
        let operation: BlockOperation = .init {
            
            guard let userEntity = self.array.first
            else {
                
                //
                completionHandler(.failure(MDEntityOperationError.cantFindEntity));
                //
                
                //
                return
                //
                
            }
            
            completionHandler(.success(userEntity))
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
    func readAllUsers(_ completionHandler: @escaping (MDOperationsResultWithCompletion<UserResponse>)) {
        
        let operation: BlockOperation = .init {
            
            //
            completionHandler(.success(self.array))
            //
            
            //
            return
            //
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
}

// MARK: - Delete
extension MDUserMemoryStorage {
    
    func deleteUser(_ userId: Int64,
                    _ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            guard let index = self.array.firstIndex(where: { $0.userId == userId })
            else {
                
                //
                completionHandler(.failure(MDEntityOperationError.cantFindEntity));
                //
                
                //
                return
                //
                
            }
            
            //
            self.array.remove(at: index)
            //
            
            //
            completionHandler(.success(()))
            //
            
            //
            return
            //
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
    func deleteAllUsers(_ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            //
            self.array.removeAll()
            //
            
            //
            completionHandler(.success(()))
            //
            
            //
            return
            //
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
}
