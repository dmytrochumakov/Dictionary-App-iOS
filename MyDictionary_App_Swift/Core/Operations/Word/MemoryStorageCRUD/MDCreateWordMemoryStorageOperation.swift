//
//  MDCreateWordMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

final class MDCreateWordMemoryStorageOperation: MDOperation {
    
    fileprivate let wordStorage: MDWordMemoryStorage
    fileprivate let word: WordResponse
    fileprivate let result: MDOperationResultWithCompletion<WordResponse>?
    
    init(wordStorage: MDWordMemoryStorage,
         word: WordResponse,
         result: MDOperationResultWithCompletion<WordResponse>?) {
        
        self.wordStorage = wordStorage
        self.word = word
        self.result = result
        
        super.init()
    }
    
    override func main() {
        self.wordStorage.arrayWords.append(word)
        self.result?(.success(word))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}

final class MDCreateWordsMemoryStorageOperation: MDOperation {
    
    fileprivate let memoryStorage: MDWordMemoryStorage
    fileprivate let words: [WordResponse]
    fileprivate let result: MDOperationsResultWithCompletion<WordResponse>?
    
    init(memoryStorage: MDWordMemoryStorage,
         words: [WordResponse],
         result: MDOperationsResultWithCompletion<WordResponse>?) {
        
        self.memoryStorage = memoryStorage
        self.words = words
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        if (self.words.isEmpty) {
            self.result?(.success(self.memoryStorage.arrayWords))
            self.finish()
        } else {
            
            self.words.forEach { word in
                self.memoryStorage.arrayWords.append(word)
            }
            
            self.result?(.success(self.memoryStorage.arrayWords))
            self.finish()
            
        }
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
