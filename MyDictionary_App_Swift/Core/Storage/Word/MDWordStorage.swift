//
//  MDWordStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.05.2021.
//

import Foundation

protocol MDWordStorageProtocol {
    func entitiesIsEmpty(storageType: MDStorageType, _ completionHandler: @escaping (MDEntitiesIsEmptyResult))
    func createWord(_ wordModel: WordModel, storageType: MDStorageType, _ completionHandler: @escaping(MDEntityResult<WordModel>))
    func readWord(fromID id: Int64, storageType: MDStorageType, _ completionHandler: @escaping(MDEntityResult<WordModel>))
    func updateWord(byID id: Int64, word: String, word_description: String, storageType: MDStorageType, _ completionHandler: @escaping(MDEntityResult<WordModel>))
    func deleteWord(_ word: WordModel, storageType: MDStorageType, _ completionHandler: @escaping(MDEntityResult<WordModel>))
}

final class MDWordStorage: MDWordStorageProtocol {
    
    fileprivate let memoryStorage: MDWordMemoryStorageProtocol
    fileprivate let coreDataStorage: MDWordCoreDataStorageProtocol
    
    init(memoryStorage: MDWordMemoryStorageProtocol,
         coreDataStorage: MDWordCoreDataStorageProtocol) {
        
        self.memoryStorage = memoryStorage
        self.coreDataStorage = coreDataStorage
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Is Empty
extension MDWordStorage {
    
    func entitiesIsEmpty(storageType: MDStorageType, _ completionHandler: @escaping (MDEntitiesIsEmptyResult)) {
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
extension MDWordStorage {
    
    func createWord(_ wordModel: WordModel, storageType: MDStorageType, _ completionHandler: @escaping(MDEntityResult<WordModel>)) {
        switch storageType {
        case .none:
            break
        case .memory:
            memoryStorage.createWord(wordModel, completionHandler)
        case .coreData:
            coreDataStorage.createWord(wordModel, completionHandler)
        }
    }
    
    func readWord(fromID id: Int64, storageType: MDStorageType, _ completionHandler: @escaping(MDEntityResult<WordModel>)) {
        switch storageType {
        case .none:
            break
        case .memory:
            memoryStorage.readWord(fromID: id, completionHandler)
        case .coreData:
            coreDataStorage.readWord(fromID: id, completionHandler)
        }
    }
    
    func updateWord(byID id: Int64, word: String, word_description: String, storageType: MDStorageType, _ completionHandler: @escaping(MDEntityResult<WordModel>)) {
        switch storageType {
        case .none:
            break
        case .memory:
            memoryStorage.updateWord(byID: id, word: word, word_description: word_description, completionHandler)
        case .coreData:
            coreDataStorage.updateWord(byID: id, word: word, word_description: word_description, completionHandler)
        }
    }
    
    func deleteWord(_ word: WordModel, storageType: MDStorageType, _ completionHandler: @escaping(MDEntityResult<WordModel>)) {
        switch storageType {
        case .none:
            break
        case .memory:
            memoryStorage.deleteWord(word, completionHandler)
        case .coreData:
            coreDataStorage.deleteWord(word, completionHandler)
        }
    }
    
}
