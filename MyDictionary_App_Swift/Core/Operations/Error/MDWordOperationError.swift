//
//  MDWordOperationError.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 10.11.2021.
//

import Foundation

enum MDWordOperationError: Error {
    case wordExists
}

// MARK: - LocalizedError
extension MDWordOperationError: LocalizedError {
    
    var errorDescription: String? {
        
        switch self {
            
        case .wordExists:
            return MDLocalizedText.conflictApiWordError.localized
        }
        
    }
    
}
