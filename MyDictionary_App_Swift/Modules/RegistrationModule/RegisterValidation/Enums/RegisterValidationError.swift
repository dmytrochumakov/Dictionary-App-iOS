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
            return KeysForTranslate.nicknameIsEmpty.localized
        case .passwordIsEmpty:
            return KeysForTranslate.passwordIsEmpty.localized
        case .confirmPasswordIsEmpty:
            return KeysForTranslate.confirmPasswordIsEmpty.localized
        case .confirmPasswordAndPasswordDoNotMatch:
            return KeysForTranslate.confirmPasswordAndPasswordDoNotMatch.localized
        }
    }
    
}
