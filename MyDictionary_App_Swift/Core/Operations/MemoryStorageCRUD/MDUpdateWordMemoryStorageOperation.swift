//
//  MDUpdateWordMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

final class MDUpdateWordMemoryStorageOperation: MDWordOperation {
    
    fileprivate let wordStorage: MDWordMemoryStorage
    fileprivate let id: Int64
    fileprivate let word: String
    fileprivate let word_description: String
    fileprivate let result: MDUpdateWordOperationResult?
    
    init(wordStorage: MDWordMemoryStorage,
         id: Int64,
         word: String,
         word_description: String,
         result: MDUpdateWordOperationResult?) {
        
        self.wordStorage = wordStorage
        self.id = id
        self.word = word
        self.word_description = word_description
        self.result = result
        
        super.init()
    }
    
    override func main() {
        guard let index = self.wordStorage.arrayWords.firstIndex(where: { $0.id == self.id })
        else {
            self.result?(.failure(MDWordOperationError.cantFindWord));
            self.finish();
            return
        }
        self.wordStorage.arrayWords[index].word = self.word
        self.wordStorage.arrayWords[index].word_description = self.word_description
        self.result?(.success(self.wordStorage.arrayWords[index]))
        self.finish()
    }
    
    deinit {
        debugPrint(Self.self, #function)
        self.finish()
    }
    
}
