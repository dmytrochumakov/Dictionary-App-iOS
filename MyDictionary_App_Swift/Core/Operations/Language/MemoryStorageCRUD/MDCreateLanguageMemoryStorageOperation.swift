//
//  MDCreateLanguageMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

final class MDCreateLanguageMemoryStorageOperation: MDOperation {
    
    fileprivate let memoryStorage: MDLanguageMemoryStorage
    fileprivate let languageEntity: LanguageEntity
    fileprivate let result: MDEntityResult<LanguageEntity>?
    
    init(memoryStorage: MDLanguageMemoryStorage,
         languageEntity: LanguageEntity,
         result: MDEntityResult<LanguageEntity>?) {
        
        self.memoryStorage = memoryStorage
        self.languageEntity = languageEntity
        self.result = result
        
        super.init()
    }
    
    override func main() {
        self.memoryStorage.array.append(languageEntity)
        self.result?(.success(languageEntity))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
