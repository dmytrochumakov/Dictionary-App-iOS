//
//  MDJWTStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

protocol MDJWTStorageProtocol {
    
    func entitiesCount(storageType: MDStorageType, _ completionHandler: @escaping (MDEntityCountResult))
    
    func createJWT(storageType: MDStorageType, authResponse: AuthResponse, _ completionHandler: @escaping(MDEntityResult<AuthResponse>))
    
    func readJWT(storageType: MDStorageType, fromAccessToken accessToken: String, _ completionHandler: @escaping(MDEntityResult<AuthResponse>))
    
    func updateJWT(storageType: MDStorageType,
                   oldAccessToken accessToken: String,
                   newAuthResponse authResponse: AuthResponse,
                   _ completionHandler: @escaping(MDEntityResult<AuthResponse>))
    
    func deleteJWT(storageType: MDStorageType, authResponse: AuthResponse, _ completionHandler: @escaping(MDEntityResult<AuthResponse>))
    
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

// MARK: - Count
extension MDJWTStorage {
    
    func entitiesCount(storageType: MDStorageType, _ completionHandler: @escaping (MDEntityCountResult)) {
        switch storageType {
        case .none:
            break
        case .memory:
            memoryStorage.entitiesCount(completionHandler)
        case .coreData:
            coreDataStorage.entitiesCount(completionHandler)
        }
    }
    
}

// MARK: - CRUD
extension MDJWTStorage {
    
    func createJWT(storageType: MDStorageType, authResponse: AuthResponse, _ completionHandler: @escaping (MDEntityResult<AuthResponse>)) {
        switch storageType {
        case .none:
            break
        case .memory:
            memoryStorage.createJWT(authResponse, completionHandler)
        case .coreData:
            coreDataStorage.createJWT(authResponse, completionHandler)
        }
    }
    
    func readJWT(storageType: MDStorageType, fromAccessToken accessToken: String, _ completionHandler: @escaping (MDEntityResult<AuthResponse>)) {
        switch storageType {
        case .none:
            break
        case .memory:
            memoryStorage.readJWT(fromAccessToken: accessToken, completionHandler)
        case .coreData:
            coreDataStorage.readJWT(fromAccessToken: accessToken, completionHandler)
        }
    }
    
    func updateJWT(storageType: MDStorageType, oldAccessToken accessToken: String, newAuthResponse authResponse: AuthResponse, _ completionHandler: @escaping (MDEntityResult<AuthResponse>)) {
        switch storageType {
        case .none:
            break
        case .memory:
            memoryStorage.updateJWT(oldAccessToken: accessToken, newAuthResponse: authResponse, completionHandler)
        case .coreData:
            coreDataStorage.updateJWT(oldAccessToken: accessToken, newAuthResponse: authResponse, completionHandler)
        }
    }
    
    func deleteJWT(storageType: MDStorageType, authResponse: AuthResponse, _ completionHandler: @escaping (MDEntityResult<AuthResponse>)) {
        switch storageType {
        case .none:
            break
        case .memory:
            memoryStorage.deleteJWT(authResponse, completionHandler)
        case .coreData:
            coreDataStorage.deleteJWT(authResponse, completionHandler)
        }
    }
    
}
