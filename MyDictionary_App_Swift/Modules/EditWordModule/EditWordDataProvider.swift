//
//  EditWordDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 28.09.2021.

import Foundation

protocol EditWordDataProviderProtocol {
    var word: WordResponse { get set }
    var editButtonIsSelected: Bool { get set }
}

final class EditWordDataProvider: EditWordDataProviderProtocol {
    
    var word: WordResponse
    var editButtonIsSelected: Bool
    
    init(word: WordResponse, editButtonIsSelected: Bool) {
        self.word = word
        self.editButtonIsSelected = editButtonIsSelected
    }
    
}
