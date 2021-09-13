//
//  RegisterTextFieldDelegate.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.09.2021.
//

import UIKit

protocol RegisterTextFieldDelegateProtocol: UITextFieldDelegate {
    var nicknameTextFieldShouldReturnAction: (() -> Void)? { get set }
    var passwordTextFieldShouldReturnAction: (() -> Void)? { get set }
    var confirmPasswordTextFieldShouldReturnAction: (() -> Void)? { get set }
}

final class RegisterTextFieldDelegate: NSObject, RegisterTextFieldDelegateProtocol {
    
    internal var nicknameTextFieldShouldReturnAction: (() -> Void)?
    internal var passwordTextFieldShouldReturnAction: (() -> Void)?
    internal var confirmPasswordTextFieldShouldReturnAction: (() -> Void)?
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension RegisterTextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (isNicknameTextField(textField)) {
            nicknameTextFieldShouldReturnAction?()
        }
        if (isPasswordTextField(textField)) {
            passwordTextFieldShouldReturnAction?()
        }
        if (isConfirmPasswordTextField(textField)) {
            confirmPasswordTextFieldShouldReturnAction?()
        }
        return true
    }
    
}

// MARK: - Check Text Field Type By Tag
fileprivate extension RegisterTextFieldDelegate {
    
    func isNicknameTextField(_ textField: UITextField) -> Bool {
        return (textField.tag == RegistrationTextFieldTag.nickname.rawValue)
    }
    
    func isPasswordTextField(_ textField: UITextField) -> Bool {
        return (textField.tag == RegistrationTextFieldTag.password.rawValue)
    }
    
    func isConfirmPasswordTextField(_ textField: UITextField) -> Bool {
        return (textField.tag == RegistrationTextFieldTag.confirmPassword.rawValue)
    }
    
}
