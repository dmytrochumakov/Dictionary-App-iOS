//
//  AuthValidationError.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.08.2021.
//

import Foundation

enum AuthValidationError: Error {
    case nicknameIsEmpty
    case passwordIsEmpty
}

extension AuthValidationError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .nicknameIsEmpty:
            return MDLocalizedText.nicknameIsEmpty.localized
        case .passwordIsEmpty:
            return MDLocalizedText.passwordIsEmpty.localized
        }
    }
    
}
