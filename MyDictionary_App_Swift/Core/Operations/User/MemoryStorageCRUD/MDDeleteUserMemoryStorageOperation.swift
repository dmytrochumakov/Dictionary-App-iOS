//
//  MDDeleteUserMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

final class MDDeleteUserMemoryStorageOperation: MDOperation {
    
    fileprivate let wordStorage: MDUserMemoryStorage
    fileprivate let result: MDUserOperationResult?
    
    init(wordStorage: MDUserMemoryStorage,
         result: MDUserOperationResult?) {
        
        self.wordStorage = wordStorage
        self.result = result
        
        super.init()
        
    }
    
    override func main() {
        guard let userEntity = self.wordStorage.userEntity
        else {
            self.result?(.failure(MDUserOperationError.cantFindUser));
            self.finish();
            return
        }
        self.wordStorage.userEntity = nil
        self.result?(.success(userEntity))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
