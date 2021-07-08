//
//  MDUpdateWordOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

final class MDUpdateWordMemoryStorageOperation: MDWordOperation {
    
    fileprivate let wordStorage: MDWordMemoryStorage
    fileprivate let uuid: UUID
    fileprivate let word: WordModel
    fileprivate let result: MDUpdateWordOperationResult?
    
    init(wordStorage: MDWordMemoryStorage,
         uuid: UUID,
         word: WordModel,
         result: MDUpdateWordOperationResult?) {
        
        self.wordStorage = wordStorage
        self.uuid = uuid
        self.word = word
        self.result = result
        
        super.init()
    }
    
    override func main() {
        guard let index = self.wordStorage.arrayWords.firstIndex(where: { $0.uuid == self.uuid })
        else {
            self.result?(.failure(OperationError.cantFindWord));
            self.finish();
            return
        }
        self.wordStorage.arrayWords[index] = self.word
        self.result?(.success(self.word))
        self.finish()
    }
    
    deinit {
        debugPrint(Self.self, #function)
        self.finish()
    }
    
}
