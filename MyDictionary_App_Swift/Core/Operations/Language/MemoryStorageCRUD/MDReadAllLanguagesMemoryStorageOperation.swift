//
//  MDReadAllLanguagesMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

final class MDReadAllLanguagesMemoryStorageOperation: MDOperation {
    
    fileprivate let memoryStorage: MDLanguageMemoryStorage
    fileprivate let result: MDOperationResultWithCompletion<[LanguageResponse]>?
    
    init(memoryStorage: MDLanguageMemoryStorage,
         result: MDOperationResultWithCompletion<[LanguageResponse]>?) {
        
        self.memoryStorage = memoryStorage
        self.result = result
        
        super.init()
    }
    
    override func main() {
        self.result?(.success(self.memoryStorage.array))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
