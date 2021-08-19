//
//  MDJWTStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

protocol MDJWTStorageProtocol {
    
    func entitiesIsEmpty(storageType: MDStorageType, _ completionHandler: @escaping (MDEntitiesIsEmptyResultWithCompletion))
    
    func createJWT(storageType: MDStorageType, jwtResponse: JWTResponse, _ completionHandler: @escaping(MDEntityResult<JWTResponse>))
    
    func readJWT(storageType: MDStorageType, fromAccessToken accessToken: String, _ completionHandler: @escaping(MDEntityResult<JWTResponse>))
    
    func updateJWT(storageType: MDStorageType,
                   oldAccessToken accessToken: String,
                   newJWTResponse jwtResponse: JWTResponse,
                   _ completionHandler: @escaping(MDEntityResult<JWTResponse>))
    
    func deleteJWT(storageType: MDStorageType, jwtResponse: JWTResponse, _ completionHandler: @escaping(MDEntityResult<JWTResponse>))
    
}

final class MDJWTStorage: MDJWTStorageProtocol {
    
    fileprivate let memoryStorage: MDJWTMemoryStorageProtocol
    fileprivate let coreDataStorage: MDJWTCoreDataStorageProtocol
    
    init(memoryStorage: MDJWTMemoryStorageProtocol,
         coreDataStorage: MDJWTCoreDataStorageProtocol) {
        
        self.memoryStorage = memoryStorage
        self.coreDataStorage = coreDataStorage
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Is Empty
extension MDJWTStorage {
    
    func entitiesIsEmpty(storageType: MDStorageType, _ completionHandler: @escaping (MDEntitiesIsEmptyResultWithCompletion)) {
        switch storageType {
        case .none:
            break
        case .memory:
            memoryStorage.entitiesIsEmpty(completionHandler)
        case .coreData:
            coreDataStorage.entitiesIsEmpty(completionHandler)
        }
    }
    
}

// MARK: - CRUD
extension MDJWTStorage {
    
    func createJWT(storageType: MDStorageType, jwtResponse: JWTResponse, _ completionHandler: @escaping (MDEntityResult<JWTResponse>)) {
        switch storageType {
        case .none:
            break
        case .memory:
            memoryStorage.createJWT(jwtResponse, completionHandler)
        case .coreData:
            coreDataStorage.createJWT(jwtResponse, completionHandler)
        }
    }
    
    func readJWT(storageType: MDStorageType, fromAccessToken accessToken: String, _ completionHandler: @escaping (MDEntityResult<JWTResponse>)) {
        switch storageType {
        case .none:
            break
        case .memory:
            memoryStorage.readJWT(fromAccessToken: accessToken, completionHandler)
        case .coreData:
            coreDataStorage.readJWT(fromAccessToken: accessToken, completionHandler)
        }
    }
    
    func updateJWT(storageType: MDStorageType, oldAccessToken accessToken: String, newJWTResponse jwtResponse: JWTResponse, _ completionHandler: @escaping (MDEntityResult<JWTResponse>)) {
        switch storageType {
        case .none:
            break
        case .memory:
            memoryStorage.updateJWT(oldAccessToken: accessToken, newJWTResponse: jwtResponse, completionHandler)
        case .coreData:
            coreDataStorage.updateJWT(oldAccessToken: accessToken, newJWTResponse: jwtResponse, completionHandler)
        }
    }
    
    func deleteJWT(storageType: MDStorageType, jwtResponse: JWTResponse, _ completionHandler: @escaping (MDEntityResult<JWTResponse>)) {
        switch storageType {
        case .none:
            break
        case .memory:
            memoryStorage.deleteJWT(jwtResponse, completionHandler)
        case .coreData:
            coreDataStorage.deleteJWT(jwtResponse, completionHandler)
        }
    }
    
}
