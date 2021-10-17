//
//  EditWordDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 28.09.2021.

import Foundation

protocol EditWordDataProviderProtocol {
    var word: WordResponse { get set }
    var copiedWord: WordResponse { get }
}

final class EditWordDataProvider: EditWordDataProviderProtocol {
    
    var word: WordResponse
    var copiedWord: WordResponse
    
    init(word: WordResponse,
         copiedWord: WordResponse) {
        
        self.word = word
        self.copiedWord = copiedWord        
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
