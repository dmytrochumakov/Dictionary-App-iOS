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
    
    var updateNicknameTextFieldCounterAction: ((Int) -> Void)? { get set }
    var updatePasswordTextFieldCounterAction: ((Int) -> Void)? { get set }
    var updateConfirmPasswordTextFieldCounterAction: ((Int) -> Void)? { get set }
    
    var nicknameTextFieldShouldClearAction: (() -> Void)? { get set }
    
}

final class RegisterTextFieldDelegate: NSObject, RegisterTextFieldDelegateProtocol {
    
    internal var nicknameTextFieldShouldReturnAction: (() -> Void)?
    internal var passwordTextFieldShouldReturnAction: (() -> Void)?
    internal var confirmPasswordTextFieldShouldReturnAction: (() -> Void)?
    
    internal var updateNicknameTextFieldCounterAction: ((Int) -> Void)?
    internal var updatePasswordTextFieldCounterAction: ((Int) -> Void)?
    internal var updateConfirmPasswordTextFieldCounterAction: ((Int) -> Void)?
    
    internal var nicknameTextFieldShouldClearAction: (() -> Void)?
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension RegisterTextFieldDelegate {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if (isNicknameTextField(textField)) {
            nicknameTextFieldShouldClearAction?()
            return true
        } else {
            return true
        }
    }
    
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
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        if (isNicknameTextField(textField)) {
            let result = result(textFieldText: textField.text,
                                rangeLength: range.length,
                                string: string,
                                maxCountCharacters: MDConstants.Text.MaxCountCharacters.nicknameTextField)
            
            if (result.success) {
                updateNicknameTextFieldCounterAction?(result.count)
            }
            
            return result.success
        }
        
        if (isPasswordTextField(textField)) {
            let result = result(textFieldText: textField.text,
                                rangeLength: range.length,
                                string: string,
                                maxCountCharacters: MDConstants.Text.MaxCountCharacters.passwordTextField)
            
            if (result.success) {
                updatePasswordTextFieldCounterAction?(result.count)
            }
            
            return result.success
        }
        
        if (isConfirmPasswordTextField(textField)) {
            let result = result(textFieldText: textField.text,
                                rangeLength: range.length,
                                string: string,
                                maxCountCharacters: MDConstants.Text.MaxCountCharacters.passwordTextField)
            
            if (result.success) {
                updateConfirmPasswordTextFieldCounterAction?(result.count)
            }
            
            return result.success
        }
        
        return true
        
    }
    
    private func result(textFieldText: String?,
                        rangeLength: Int,
                        string: String,
                        maxCountCharacters: Int) -> (count: Int, success: Bool) {
        
        let count: Int = computeCount(textFieldText: textFieldText,
                                      rangeLength: rangeLength,
                                      string: string)
        
        return (count, (count <= maxCountCharacters))
        
    }
    
    private func computeCount(textFieldText: String?,
                              rangeLength: Int,
                              string: String) -> Int {
        
        return (textFieldText?.count ?? .zero) + (string.count - rangeLength)
        
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
