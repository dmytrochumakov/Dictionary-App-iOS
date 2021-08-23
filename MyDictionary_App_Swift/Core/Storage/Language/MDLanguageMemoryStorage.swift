//
//  MDLanguageMemoryStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

protocol MDLanguageMemoryStorageProtocol {
    
}

final class MDLanguageMemoryStorage: MDLanguageMemoryStorageProtocol {
    
    var array: [LanguageEntity]
    
    init(array: [LanguageEntity]) {
        self.array = array
    }
    
}
