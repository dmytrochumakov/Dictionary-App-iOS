//
//  AuthTextFieldDelegate.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 12.08.2021.
//

import UIKit

protocol AuthTextFieldDelegateProtocol: UITextFieldDelegate {
    var nicknameTextFieldShouldReturnAction: (() -> Void)? { get set }
    var passwordTextFieldShouldReturnAction: (() -> Void)? { get set }
}

final class AuthTextFieldDelegate: NSObject, AuthTextFieldDelegateProtocol {
    
    internal var nicknameTextFieldShouldReturnAction: (() -> Void)?
    internal var passwordTextFieldShouldReturnAction: (() -> Void)?    
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension AuthTextFieldDelegate {       
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (isNicknameTextField(textField)) {
            nicknameTextFieldShouldReturnAction?()
        }
        if (isPasswordTextField(textField)) {
            passwordTextFieldShouldReturnAction?()
        }
        return true
    }
    
}

// MARK: - Check Text Field Type By Tag
fileprivate extension AuthTextFieldDelegate {
    
    func isNicknameTextField(_ textField: UITextField) -> Bool {
        return (textField.tag == AuthenticationTextFieldTag.nickname.rawValue)
    }
    
    func isPasswordTextField(_ textField: UITextField) -> Bool {
        return (textField.tag == AuthenticationTextFieldTag.password.rawValue)
    }
    
}
