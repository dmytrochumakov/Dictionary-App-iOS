//
//  MDJWTMemoryStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

protocol MDJWTMemoryStorageProtocol: MDCRUDJWTProtocol,
                                     MDEntitiesCountProtocol {
    
}

final class MDJWTMemoryStorage: MDJWTMemoryStorageProtocol {
    
    fileprivate let operationQueueService: OperationQueueServiceProtocol
    
    var authResponse: AuthResponse?
    
    init(operationQueueService: OperationQueueServiceProtocol,
         authResponse: AuthResponse?) {
        
        self.operationQueueService = operationQueueService
        self.authResponse = authResponse
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDJWTMemoryStorage {
    
    func entitiesCount(_ completionHandler: @escaping (MDEntityCountResult)) {
        if (authResponse == nil) {
            completionHandler(.success(0))
        } else {
            completionHandler(.success(1))
        }
    }
    
}

extension MDJWTMemoryStorage {
    
    func createJWT(_ authResponse: AuthResponse, _ completionHandler: @escaping (MDEntityResult<AuthResponse>)) {
        let operation = MDCreateJWTMemoryStorageOperation.init(memoryStorage: self,
                                                               authResponse: authResponse) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readJWT(fromAccessToken accessToken: String, _ completionHandler: @escaping (MDEntityResult<AuthResponse>)) {
        let operation = MDReadJWTMemoryStorageOperation.init(memoryStorage: self,
                                                             accessToken: accessToken) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func updateJWT(byAuthResponse authResponse: AuthResponse, _ completionHandler: @escaping (MDEntityResult<AuthResponse>)) {
        
    }
    
    func deleteJWT(_ authResponse: AuthResponse, _ completionHandler: @escaping (MDEntityResult<AuthResponse>)) {
        
    }
    
}
