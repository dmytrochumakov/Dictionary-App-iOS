//
//  MDLanguageModel.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 07.11.2021.
//

import Foundation

struct MDLanguageModel {
    let id: UInt8
    let name: String
    let translatedName: String
}

// MARK: - MDTextForSearchProtocol
extension MDLanguageModel: MDTextForSearchProtocol {
    
    var textForSearch: String {
        return name
    }
    
}
