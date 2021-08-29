//
//  MDCreateLanguagesMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

final class MDCreateLanguagesMemoryStorageOperation: MDOperation {
    
    fileprivate let memoryStorage: MDLanguageMemoryStorage
    fileprivate let languageEntities: [LanguageResponse]
    fileprivate let result: MDEntityResult<[LanguageResponse]>?
    
    init(memoryStorage: MDLanguageMemoryStorage,
         languageEntities: [LanguageResponse],
         result: MDEntityResult<[LanguageResponse]>?) {
        
        self.memoryStorage = memoryStorage
        self.languageEntities = languageEntities
        self.result = result
        
        super.init()
    }
    
    override func main() {
        self.memoryStorage.array = self.languageEntities
        self.result?(.success(languageEntities))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
