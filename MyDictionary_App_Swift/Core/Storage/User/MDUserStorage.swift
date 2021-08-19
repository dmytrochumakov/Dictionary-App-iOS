//
//  MDUserStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

protocol MDUserStorageProtocol {
    func entitiesIsEmpty(storageType: MDStorageType, _ completionHandler: @escaping (MDEntitiesIsEmptyResultWithCompletion))
    func createUser(_ userEntity: UserEntity, storageType: MDStorageType, _ completionHandler: @escaping(MDEntityResult<UserEntity>))
    func readUser(fromUserID userId: Int64, storageType: MDStorageType, _ completionHandler: @escaping(MDEntityResult<UserEntity>))
    func deleteUser(_ userEntity: UserEntity, storageType: MDStorageType,_ completionHandler: @escaping(MDEntityResult<UserEntity>))
}

final class MDUserStorage: MDUserStorageProtocol {
    
    fileprivate let memoryStorage: MDUserMemoryStorageProtocol
    fileprivate let coreDataStorage: MDUserCoreDataStorageProtocol
    
    init(memoryStorage: MDUserMemoryStorageProtocol,
         coreDataStorage: MDUserCoreDataStorageProtocol) {
        
        self.memoryStorage = memoryStorage
        self.coreDataStorage = coreDataStorage
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Is Empty
extension MDUserStorage {
    
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
extension MDUserStorage {
    
    func createUser(_ userEntity: UserEntity, storageType: MDStorageType, _ completionHandler: @escaping (MDEntityResult<UserEntity>)) {
        switch storageType {
        case .none:
            break
        case .memory:
            memoryStorage.createUser(userEntity, completionHandler)
        case .coreData:
            coreDataStorage.createUser(userEntity, completionHandler)
        }
    }
    
    func readUser(fromUserID userId: Int64, storageType: MDStorageType, _ completionHandler: @escaping (MDEntityResult<UserEntity>)) {
        switch storageType {
        case .none:
            break
        case .memory:
            memoryStorage.readUser(fromUserID: userId, completionHandler)
        case .coreData:
            coreDataStorage.readUser(fromUserID: userId, completionHandler)
        }
    }
    
    func deleteUser(_ userEntity: UserEntity, storageType: MDStorageType, _ completionHandler: @escaping (MDEntityResult<UserEntity>)) {
        switch storageType {
        case .none:
            break
        case .memory:
            memoryStorage.deleteUser(userEntity, completionHandler)
        case .coreData:
            coreDataStorage.deleteUser(userEntity, completionHandler)
        }
    }
    
}
