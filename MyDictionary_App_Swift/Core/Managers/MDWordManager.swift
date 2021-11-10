//
//  MDWordManager.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 10.11.2021.
//

import Foundation

protocol MDWordManagerProtocol {
    
}

final class MDWordManager: MDWordManagerProtocol {
    
    fileprivate let wordCoreDataStorage: MDWordCoreDataStorageProtocol
    
    init(wordCoreDataStorage: MDWordCoreDataStorageProtocol) {
        self.wordCoreDataStorage = wordCoreDataStorage
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
