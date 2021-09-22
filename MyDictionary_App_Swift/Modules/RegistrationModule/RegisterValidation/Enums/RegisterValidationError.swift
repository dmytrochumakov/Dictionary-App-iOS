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
            return LocalizedText.nicknameIsEmpty.localized
        case .passwordIsEmpty:
            return LocalizedText.passwordIsEmpty.localized
        case .confirmPasswordIsEmpty:
            return LocalizedText.confirmPasswordIsEmpty.localized
        case .confirmPasswordAndPasswordDoNotMatch:
            return LocalizedText.confirmPasswordAndPasswordDoNotMatch.localized
        }
    }
    
}
