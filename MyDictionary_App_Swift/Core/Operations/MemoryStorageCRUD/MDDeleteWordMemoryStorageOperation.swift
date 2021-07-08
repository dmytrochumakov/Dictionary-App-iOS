//
//  MDDeleteWordMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

final class MDDeleteWordMemoryStorageOperation: MDWordOperation {
    
    fileprivate let wordStorage: MDWordMemoryStorage
    fileprivate let word: WordModel
    fileprivate let result: MDDeleteWordOperationResult?
    
    init(wordStorage: MDWordMemoryStorage,
         word: WordModel,
         result: MDDeleteWordOperationResult?) {
        
        self.wordStorage = wordStorage
        self.word = word
        self.result = result
        
        super.init()
    }
    
    override func main() {
        guard let index = self.wordStorage.arrayWords.firstIndex(where: { $0.uuid == self.word.uuid })
        else {
            self.result?(.failure(OperationError.cantFindWord));
            self.finish();
            return
        }
        self.wordStorage.arrayWords.remove(at: index)
        self.result?(.success(self.word))
        self.finish()
    }
    
    deinit {
        debugPrint(Self.self, #function)
        self.finish()
    }
    
}
