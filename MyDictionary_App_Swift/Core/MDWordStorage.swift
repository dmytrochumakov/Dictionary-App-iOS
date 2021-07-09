//
//  MDWordStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.05.2021.
//

import Foundation

protocol MDWordStorageProtocol {    
    func createWord(_ wordModel: WordModel, storageType: MDWordStorageType, _ completionHandler: @escaping(MDCreateWordResult))
    func readWord(fromUUID uuid: UUID, storageType: MDWordStorageType, _ completionHandler: @escaping(MDReadWordResult))
    func updateWord(byUUID uuid: UUID, word: String, wordDescription: String, storageType: MDWordStorageType, _ completionHandler: @escaping(MDUpdateWordResult))
    func deleteWord(_ word: WordModel, storageType: MDWordStorageType, _ completionHandler: @escaping(MDDeleteWordResult))
}

final class MDWordStorage: MDWordStorageProtocol {
    
    fileprivate let memoryStorage: MDWordMemoryStorageProtocol
    
    init(memoryStorage: MDWordMemoryStorageProtocol) {
        
        self.memoryStorage = memoryStorage
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - CRUD
extension MDWordStorage {
    
    func createWord(_ wordModel: WordModel, storageType: MDWordStorageType, _ completionHandler: @escaping(MDCreateWordResult)) {
        switch storageType {
        case .none:
            break
        case .memory:
            memoryStorage.createWord(wordModel, completionHandler)
        case .coreData:
            break
        }
    }
    
    func readWord(fromUUID uuid: UUID, storageType: MDWordStorageType, _ completionHandler: @escaping(MDReadWordResult)) {
        switch storageType {
        case .none:
            break
        case .memory:
            memoryStorage.readWord(fromUUID: uuid, completionHandler)
        case .coreData:
            break
        }
    }
    
    func updateWord(byUUID uuid: UUID, word: String, wordDescription: String, storageType: MDWordStorageType, _ completionHandler: @escaping(MDUpdateWordResult)) {
        switch storageType {
        case .none:
            break
        case .memory:
            memoryStorage.updateWord(byUUID: uuid, word: word, wordDescription: wordDescription, completionHandler)
        case .coreData:
            break
        }
    }
    
    func deleteWord(_ word: WordModel, storageType: MDWordStorageType, _ completionHandler: @escaping(MDDeleteWordResult)) {
        switch storageType {
        case .none:
            break
        case .memory:
            memoryStorage.deleteWord(word, completionHandler)
        case .coreData:
            break
        }
    }
    
}
