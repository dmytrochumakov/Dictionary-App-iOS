//
//  EditWordDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 28.09.2021.

import Foundation

protocol EditWordDataProviderProtocol {
    var word: CDWordEntity { get set }
    var copiedWord: CDWordEntity { get }
}

final class EditWordDataProvider: EditWordDataProviderProtocol {
    
    var word: CDWordEntity
    var copiedWord: CDWordEntity
    
    init(word: CDWordEntity,
         copiedWord: CDWordEntity) {
        
        self.word = word
        self.copiedWord = copiedWord        
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
