//
//  EditWordDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 28.09.2021.

import Foundation

protocol EditWordDataProviderProtocol {
    var word: WordResponse { get set }
}

final class EditWordDataProvider: EditWordDataProviderProtocol {
    
    var word: WordResponse
    
    init(word: WordResponse) {
        self.word = word
    }
    
}
