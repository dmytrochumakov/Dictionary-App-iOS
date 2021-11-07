//
//  EditWordDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 28.09.2021.

import Foundation

protocol EditWordDataProviderProtocol {
    var word: MDWordModel { get set }
    var copiedWord: MDWordModel { get }
}

final class EditWordDataProvider: EditWordDataProviderProtocol {
    
    var word: MDWordModel
    var copiedWord: MDWordModel
    
    init(word: MDWordModel,
         copiedWord: MDWordModel) {
        
        self.word = word
        self.copiedWord = copiedWord        
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
