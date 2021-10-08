//
//  MDAPIWordError.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.10.2021.
//

import Foundation

enum MDAPIWordError: Error {
    case conflict
}

extension MDAPIWordError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .conflict:
            return MDLocalizedText.conflictApiWordError.localized
        }
    }
    
}
