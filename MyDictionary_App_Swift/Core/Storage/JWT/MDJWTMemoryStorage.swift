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
    
    fileprivate let operationQueueService: OperationQueueServiceProtocol
    
    var jwtResponse: JWTResponse?
    
    init(operationQueueService: OperationQueueServiceProtocol,
         jwtResponse: JWTResponse?) {
        
        self.operationQueueService = operationQueueService
        self.jwtResponse = jwtResponse
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDJWTMemoryStorage {
    
    func entitiesCount(_ completionHandler: @escaping (MDEntitiesCountResultWithCompletion)) {
        if (jwtResponse == nil) {
            completionHandler(.success(0))
        } else {
            completionHandler(.success(1))
        }
    }
    
    func entitiesIsEmpty(_ completionHandler: @escaping (MDEntitiesIsEmptyResultWithCompletion)) {
        if (jwtResponse == nil) {
            completionHandler(.success(true))
        } else {
            completionHandler(.success(false))
        }
    }
    
}

extension MDJWTMemoryStorage {
    
    func createJWT(_ jwtResponse: JWTResponse, _ completionHandler: @escaping(MDOperationResultWithCompletion<JWTResponse>)) {
        let operation = MDCreateJWTMemoryStorageOperation.init(memoryStorage: self,
                                                               jwtResponse: jwtResponse) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readFirstJWT(_ completionHandler: @escaping(MDOperationResultWithCompletion<JWTResponse>)) {
        let operation = MDReadFirstJWTMemoryStorageOperation.init(memoryStorage: self) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readJWT(fromAccessToken accessToken: String, _ completionHandler: @escaping(MDOperationResultWithCompletion<JWTResponse>)) {
        let operation = MDReadJWTMemoryStorageOperation.init(memoryStorage: self,
                                                             accessToken: accessToken) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }       
    
    func updateJWT(oldAccessToken accessToken: String, newJWTResponse jwtResponse: JWTResponse, _ completionHandler: @escaping(MDOperationResultWithCompletion<JWTResponse>)) {
        let operation = MDUpdateJWTMemoryStorageOperation.init(memoryStorage: self,
                                                               oldAccessToken: accessToken,
                                                               newJWTResponse: jwtResponse) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }    
    
    func deleteJWT(_ jwtResponse: JWTResponse, _ completionHandler: @escaping(MDOperationResultWithCompletion<JWTResponse>)) {
        let operation = MDDeleteJWTMemoryStorageOperation.init(memoryStorage: self,
                                                               jwtResponse: jwtResponse) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func deleteAllJWT(_ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        let operation: MDDeleteAllJWTMemoryStorageOperation = .init(memoryStorage: self) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
}
