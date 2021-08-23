//
//  MDDeleteAllWordsMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

final class MDDeleteAllWordsMemoryStorageOperation: MDOperation {
    
    fileprivate let wordStorage: MDWordMemoryStorage
    fileprivate let result: MDEntityResult<Void>?
    
    init(wordStorage: MDWordMemoryStorage,
         result: MDEntityResult<Void>?) {
        
        self.wordStorage = wordStorage
        self.result = result
        
        super.init()
    }
    
    override func main() {
        self.wordStorage.arrayWords.removeAll()
        self.result?(.success(()))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
