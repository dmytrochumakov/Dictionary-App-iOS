//
//  MDReadWordMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

final class MDReadWordMemoryStorageOperation: MDOperation {
    
    fileprivate let wordStorage: MDWordMemoryStorage
    fileprivate let id: Int64
    fileprivate let result: MDEntityResult<WordEntity>?
    
    init(wordStorage: MDWordMemoryStorage,
         id: Int64,
         result: MDEntityResult<WordEntity>?) {
        
        self.wordStorage = wordStorage
        self.id = id
        self.result = result
        
        super.init()
    }
    
    override func main() {
        guard let word = self.wordStorage.arrayWords.first(where: { $0.id == self.id })
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
