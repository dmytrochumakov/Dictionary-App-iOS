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
    
    var array: [JWTResponse]
    
    init(operationQueue: OperationQueue,
         array: [JWTResponse]) {
        
        self.operationQueue = operationQueue
        self.array = array
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

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

extension MDJWTMemoryStorage {
    
    func createJWT(_ jwtResponse: JWTResponse, _ completionHandler: @escaping(MDOperationResultWithCompletion<JWTResponse>)) {
        let operation = MDCreateJWTMemoryStorageOperation.init(memoryStorage: self,
                                                               jwtResponse: jwtResponse) { result in
            completionHandler(result)
        }
        operationQueue.addOperation(operation)
    }
    
    func readFirstJWT(_ completionHandler: @escaping(MDOperationResultWithCompletion<JWTResponse>)) {
        let operation = MDReadFirstJWTMemoryStorageOperation.init(memoryStorage: self) { result in
            completionHandler(result)
        }
        operationQueue.addOperation(operation)
    }
    
    func readJWT(fromAccessToken accessToken: String, _ completionHandler: @escaping(MDOperationResultWithCompletion<JWTResponse>)) {
        let operation = MDReadJWTMemoryStorageOperation.init(memoryStorage: self,
                                                             accessToken: accessToken) { result in
            completionHandler(result)
        }
        operationQueue.addOperation(operation)
    }
    
    func readAllJWT(_ completionHandler: @escaping(MDOperationsResultWithCompletion<JWTResponse>)) {
        let operation = MDReadAllJWTMemoryStorageOperation.init(memoryStorage: self) { result in
            completionHandler(result)
        }
        operationQueue.addOperation(operation)
    }
    
    func updateJWT(oldAccessToken accessToken: String,
                   newJWTResponse jwtResponse: JWTResponse,
                   _ completionHandler: @escaping(MDOperationResultWithCompletion<Void>)) {
        
        let operation = MDUpdateJWTMemoryStorageOperation.init(memoryStorage: self,
                                                               oldAccessToken: accessToken,
                                                               newJWTResponse: jwtResponse) { result in
            completionHandler(result)
        }
        
        operationQueue.addOperation(operation)
        
    }    
    
    func deleteJWT(_ byAccessToken: String, _ completionHandler: @escaping(MDOperationResultWithCompletion<Void>)) {
        let operation = MDDeleteJWTMemoryStorageOperation.init(memoryStorage: self,
                                                               accessToken: byAccessToken) { result in
            completionHandler(result)
        }
        operationQueue.addOperation(operation)
    }
    
    func deleteAllJWT(_ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        let operation: MDDeleteAllJWTMemoryStorageOperation = .init(memoryStorage: self) { result in
            completionHandler(result)
        }
        operationQueue.addOperation(operation)
    }
    
}
