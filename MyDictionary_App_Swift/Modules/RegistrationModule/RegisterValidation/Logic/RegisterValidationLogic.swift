//
//  RegisterValidationLogic.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.09.2021.
//

import Foundation

protocol RegisterValidationLogicProtocol {
    
    static func textIsEmpty(validationType: RegisterValidationType, text: String?) -> RegisterValidationResult
    
    static func confirmPasswordIsEqualPassword(validationType: RegisterValidationType,
                                               confirmPassword: String?,
                                               password: String?) -> RegisterValidationResult
    
}

struct RegisterValidationLogic: RegisterValidationLogicProtocol {
    
    static func textIsEmpty(validationType: RegisterValidationType, text: String?) -> RegisterValidationResult {
        switch validationType {
        case .nickname:
            if (MDConstants.Text.textIsEmpty(text)) {
                return .init(validationType: validationType,
                             validationError: .nicknameIsEmpty)
            } else {
                return .init(validationType: validationType,
                             validationError: nil)
            }
        case .password:
            if (MDConstants.Text.textIsEmpty(text)) {
                return .init(validationType: validationType,
                             validationError: .passwordIsEmpty)
            } else {
                return .init(validationType: validationType,
                             validationError: nil)
            }
        case .confirmPassword:
            if (MDConstants.Text.textIsEmpty(text)) {
                return .init(validationType: validationType,
                             validationError: .confirmPasswordIsEmpty)
            } else {
                return .init(validationType: validationType,
                             validationError: nil)
            }
        }
    }        
    
    static func confirmPasswordIsEqualPassword(validationType: RegisterValidationType,
                                               confirmPassword: String?,
                                               password: String?) -> RegisterValidationResult {
        
        if (textIsEmpty(validationType: .password, text: password).validationError != nil) {
            return textIsEmpty(validationType: .password, text: password)
        }
        
        if (textIsEmpty(validationType: .confirmPassword, text: confirmPassword).validationError != nil) {
            return textIsEmpty(validationType: .confirmPassword, text: confirmPassword)
        }
        
        if (confirmPassword == password) {
            return .init(validationType: validationType,
                         validationError: nil)
        } else {
            return .init(validationType: validationType,
                         validationError: .confirmPasswordAndPasswordDoNotMatch)
        }
                
    }
    
}
