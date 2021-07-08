//
//  MDReadWordOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

final class MDReadWordMemoryStorageOperation: MDWordOperation {
    
    fileprivate let wordStorage: MDWordMemoryStorage
    fileprivate let uuid: UUID
    fileprivate let result: MDReadWordOperationResult?
    
    init(wordStorage: MDWordMemoryStorage,
         uuid: UUID,
         result: MDReadWordOperationResult?) {
        
        self.wordStorage = wordStorage
        self.uuid = uuid
        self.result = result
        
        super.init()
    }
    
    override func main() {
        guard let word = self.wordStorage.arrayWords.first(where: { $0.uuid == self.uuid })
        else {
            self.result?(.failure(OperationError.cantFindWord));
            self.finish();
            return
        }
        self.result?(.success(word))
        self.finish()
    }
    
    deinit {
        debugPrint(Self.self, #function)
        self.finish()
    }
    
}
