//
//  MDReadWordMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

final class MDReadWordMemoryStorageOperation: MDOperation {
    
    fileprivate let wordStorage: MDWordMemoryStorage
    fileprivate let wordId: Int64
    fileprivate let result: MDEntityResult<WordEntity>?
    
    init(wordStorage: MDWordMemoryStorage,
         wordId: Int64,
         result: MDEntityResult<WordEntity>?) {
        
        self.wordStorage = wordStorage
        self.wordId = wordId
        self.result = result
        
        super.init()
    }
    
    override func main() {
        guard let word = self.wordStorage.arrayWords.first(where: { $0.wordId == self.wordId })
        else {
            self.result?(.failure(MDEntityOperationError.cantFindEntity));
            self.finish();
            return
        }
        self.result?(.success(word))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
