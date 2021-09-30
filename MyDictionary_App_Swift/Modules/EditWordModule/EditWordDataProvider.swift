//
//  EditWordDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 28.09.2021.

import Foundation

protocol EditWordDataProviderProtocol {
    var word: WordResponse { get set }
    var copiedWord: WordResponse { get }
    var editButtonIsSelected: Bool { get set }
}

final class EditWordDataProvider: EditWordDataProviderProtocol {
    
    var word: WordResponse
    var copiedWord: WordResponse
    var editButtonIsSelected: Bool
    
    init(word: WordResponse,
         copiedWord: WordResponse,
         editButtonIsSelected: Bool) {
        
        self.word = word
        self.copiedWord = copiedWord
        self.editButtonIsSelected = editButtonIsSelected
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
