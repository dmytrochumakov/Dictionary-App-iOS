//
//  EditWordDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 28.09.2021.

import Foundation

protocol EditWordDataProviderProtocol {
    
    var transmittedWord: CDWordEntity { get }
    var wordText: String { get set }
    var wordDescription: String { get set }
    
    func updateWord()
    
}

final class EditWordDataProvider: EditWordDataProviderProtocol {
    
    var transmittedWord: CDWordEntity
    var wordText: String
    var wordDescription: String
    
    init(transmittedWord: CDWordEntity,
         wordText: String,
         wordDescription: String) {
        
        self.transmittedWord = transmittedWord
        self.wordText = wordText
        self.wordDescription = wordDescription
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension EditWordDataProvider {
    
    func updateWord() {
        self.transmittedWord.wordText = wordText
        self.transmittedWord.wordDescription = wordDescription
    }
    
}
