//
//  MDAPIAuthError.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 14.08.2021.
//

import Foundation

enum MDAPIAuthError: Error {
    case unauthorized
    case conflict
}

extension MDAPIAuthError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .unauthorized:
            return MDLocalizedText.unauthorizedApiAuthError.localized
        case .conflict:
            return MDLocalizedText.conflictApiAuthError.localized
        }
    }
    
}
