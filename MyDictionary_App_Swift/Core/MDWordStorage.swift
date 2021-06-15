//
//  MDWordStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.05.2021.
//

import Foundation

final class MDWordStorage: MDWordStorageProtocol {
    
    fileprivate let storageType: MDWordStorageType
    fileprivate let memoryStorage: MDWordMemoryStorageProtocol
    
    init(storageType: MDWordStorageType,
         memoryStorage: MDWordMemoryStorageProtocol) {
        
        self.storageType = storageType
        self.memoryStorage = memoryStorage
        
    }
    
}

// MARK: - CRUD
extension MDWordStorage {
    
    func createWord(_ wordModel: WordModel, _ completionHandler: @escaping(MDCreateWordResult)) {
        switch storageType {
        case .none:
            break
        case .memory:
            memoryStorage.createWord(wordModel, completionHandler)
        }
    }
    
    func readWord(fromUUID uuid: UUID, _ completionHandler: @escaping(MDReadWordResult)) {
        switch storageType {
        case .none:
            break
        case .memory:
            memoryStorage.readWord(fromUUID: uuid, completionHandler)
        }
    }
    
    func updateWord(_ word: WordModel, _ completionHandler: @escaping(MDUpdateWordResult)) {
        switch storageType {
        case .none:
            break
        case .memory:
            memoryStorage.updateWord(word, completionHandler)
        }
    }
    
    func deleteWord(_ word: WordModel, _ completionHandler: @escaping(MDDeleteWordResult)) {
        switch storageType {
        case .none:
            break
        case .memory:
            memoryStorage.deleteWord(word, completionHandler)
        }
    }
    
}
