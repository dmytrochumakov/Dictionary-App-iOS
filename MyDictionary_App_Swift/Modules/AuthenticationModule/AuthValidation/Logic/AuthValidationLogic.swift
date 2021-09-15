//
//  AuthValidationLogic.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.08.2021.
//

import Foundation

protocol AuthValidationLogicProtocol {
    static func textIsEmpty(validationType: AuthValidationType, text: String?) -> AuthValidationResult
}

struct AuthValidationLogic: AuthValidationLogicProtocol {
    
    static func textIsEmpty(validationType: AuthValidationType, text: String?) -> AuthValidationResult {
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
        }
    }
    
}
