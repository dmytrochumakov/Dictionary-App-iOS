//
//  MDEditWordError.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 30.09.2021.
//

import Foundation

enum MDEditWordError: Error {
    case wordTextIsEmpty
    case wordDescriptionIsEmpty
}

// MARK: - LocalizedError
extension MDEditWordError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .wordTextIsEmpty:
            return MDLocalizedText.wordTextIsEmpty.localized
        case .wordDescriptionIsEmpty:
            return MDLocalizedText.wordDescriptionIsEmpty.localized
        }
    }
    
}
