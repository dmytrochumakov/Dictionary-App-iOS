//
//  RegisterValidationError.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.09.2021.
//

import Foundation

enum RegisterValidationError {
    case nicknameIsEmpty
    case passwordIsEmpty
    case confirmPasswordIsEmpty
    case confirmPasswordAndPasswordDoNotMatch
}

extension RegisterValidationError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .nicknameIsEmpty:
            return MDLocalizedText.nicknameIsEmpty.localized
        case .passwordIsEmpty:
            return MDLocalizedText.passwordIsEmpty.localized
        case .confirmPasswordIsEmpty:
            return MDLocalizedText.confirmPasswordIsEmpty.localized
        case .confirmPasswordAndPasswordDoNotMatch:
            return MDLocalizedText.confirmPasswordAndPasswordDoNotMatch.localized
        }
    }
    
}
