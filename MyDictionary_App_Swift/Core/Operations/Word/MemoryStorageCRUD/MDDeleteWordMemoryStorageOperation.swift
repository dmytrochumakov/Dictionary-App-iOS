//
//  MDDeleteWordMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

final class MDDeleteWordMemoryStorageOperation: MDOperation {
    
    fileprivate let wordStorage: MDWordMemoryStorage
    fileprivate let word: WordModel
    fileprivate let result: MDWordOperationResult?
    
    init(wordStorage: MDWordMemoryStorage,
         word: WordModel,
         result: MDWordOperationResult?) {
        
        self.wordStorage = wordStorage
        self.word = word
        self.result = result
        
        super.init()
    }
    
    override func main() {
        guard let index = self.wordStorage.arrayWords.firstIndex(where: { $0.id == self.word.id })
        else {
            self.result?(.failure(MDWordOperationError.cantFindWord));
            self.finish();
            return
        }
        self.wordStorage.arrayWords.remove(at: index)
        self.result?(.success(self.word))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
