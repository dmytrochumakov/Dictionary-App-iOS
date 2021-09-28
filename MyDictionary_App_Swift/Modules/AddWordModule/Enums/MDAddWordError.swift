//
//  MDAddWordError.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 28.09.2021.
//

import Foundation

enum MDAddWordError: Error {
    case wordTextIsEmpty
    case wordDescriptionIsEmpty
}

// MARK: - LocalizedError
extension MDAddWordError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .wordTextIsEmpty:             
            return MDLocalizedText.wordTextIsEmpty.localized
        case .wordDescriptionIsEmpty:
            return MDLocalizedText.wordDescriptionIsEmpty.localized
        }
    }
    
}
