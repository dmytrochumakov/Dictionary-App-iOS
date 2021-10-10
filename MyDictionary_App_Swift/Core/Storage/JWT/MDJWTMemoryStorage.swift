//
//  MDJWTMemoryStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

protocol MDJWTMemoryStorageProtocol: MDCRUDJWTProtocol,
                                     MDStorageInterface {
    
}

final class MDJWTMemoryStorage: MDJWTMemoryStorageProtocol {
    
    fileprivate let operationQueue: OperationQueue
    fileprivate var array: [JWTResponse]
    
    init(operationQueue: OperationQueue,
         array: [JWTResponse]) {
        
        self.operationQueue = operationQueue
        self.array = array
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Entities
extension MDJWTMemoryStorage {
    
    func entitiesCount(_ completionHandler: @escaping (MDEntitiesCountResultWithCompletion)) {
        self.readAllJWT { result in
            switch result {
            case .success(let entities):
                completionHandler(.success(entities.count))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func entitiesIsEmpty(_ completionHandler: @escaping (MDEntitiesIsEmptyResultWithCompletion)) {
        self.readAllJWT { result in
            switch result {
            case .success(let entities):
                completionHandler(.success(entities.isEmpty))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}

// MARK: - Create
extension MDJWTMemoryStorage {
    
    func createJWT(_ jwtResponse: JWTResponse,
                   _ completionHandler: @escaping(MDOperationResultWithCompletion<JWTResponse>)) {
        
        let operation: BlockOperation = .init {
            
            //
            self.array.append(jwtResponse)
            //
            
            //
            completionHandler(.success(jwtResponse))
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

// MARK: - Read
extension MDJWTMemoryStorage {
    
    func readFirstJWT(_ completionHandler: @escaping(MDOperationResultWithCompletion<JWTResponse>)) {
        
        let operation: BlockOperation = .init {
            
            guard let jwtResponse = self.array.first
            else {
                
                //
                completionHandler(.failure(MDEntityOperationError.cantFindEntity))
                //
                
                //
                return
                //
                
            }
            
            //
            completionHandler(.success(jwtResponse))
            //
            
            //
            return
            //
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
    func readJWT(fromAccessToken accessToken: String,
                 _ completionHandler: @escaping(MDOperationResultWithCompletion<JWTResponse>)) {
        
        let operation: BlockOperation = .init {
            
            guard let jwtResponse = self.array.first(where: { $0.accessToken == accessToken })
            else {
                
                //
                completionHandler(.failure(MDEntityOperationError.cantFindEntity));
                //
                
                //
                return
                //
                
            }
            
            //
            completionHandler(.success(jwtResponse))
            //
            
            //
            return
            //
            
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
    func readAllJWT(_ completionHandler: @escaping(MDOperationsResultWithCompletion<JWTResponse>)) {
        
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

// MARK: - Update
extension MDJWTMemoryStorage {
    
    func updateJWT(oldAccessToken accessToken: String,
                   newJWTResponse jwtResponse: JWTResponse,
                   _ completionHandler: @escaping(MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            guard let index = self.array.firstIndex(where: { $0.accessToken == accessToken })
            else {
                
                //
                completionHandler(.failure(MDEntityOperationError.cantFindEntity));
                //
                
                //
                return
                //
                
            }
            
            //
            self.array[index] = jwtResponse
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

// MARK: - Delete
extension MDJWTMemoryStorage {
    
    func deleteJWT(_ byAccessToken: String,
                   _ completionHandler: @escaping(MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            guard let index = self.array.firstIndex(where: { $0.accessToken == byAccessToken })
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
    
    func deleteAllJWT(_ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
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
