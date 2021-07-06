//
//  MDUpdateWordOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

final class MDUpdateWordMemoryStorageOperation: MDWordOperation {
    
    fileprivate let wordStorage: MDWordStorageProtocol
    fileprivate let word: WordModel
    fileprivate let result: MDUpdateWordOperationResult?
    
    init(wordStorage: MDWordStorageProtocol,
         word: WordModel,
         result: MDUpdateWordOperationResult?) {
        
        self.wordStorage = wordStorage
        self.word = word
        self.result = result
        
        super.init()
    }
    
    override func main() {
        self.wordStorage.updateWord(word) { [weak self] result in
            self?.result?(result)
            self?.finish()
        }
    }
    
    deinit {
        debugPrint(Self.self, #function)
        self.finish()
    }
    
}
