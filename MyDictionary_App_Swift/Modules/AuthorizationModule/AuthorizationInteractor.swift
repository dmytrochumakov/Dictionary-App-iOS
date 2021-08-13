//
//  AuthorizationInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 12.08.2021.

import UIKit

protocol AuthorizationInteractorInputProtocol {
    var textFieldDelegate: AuthTextFieldDelegateProtocol { get }
    func nicknameTextFieldEditingDidChangeAction(_ text: String?)
    func passwordTextFieldEditingDidChangeAction(_ text: String?)
    func loginButtonClicked()
}

protocol AuthorizationInteractorOutputProtocol: AnyObject {
    func makePasswordFieldActive()
    func hideKeyboard()
    func showCourseList()
    func showValidationError(_ error: Error)
}

protocol AuthorizationInteractorProtocol: AuthorizationInteractorInputProtocol,
                                          AuthorizationDataManagerOutputProtocol {
    var interactorOutput: AuthorizationInteractorOutputProtocol? { get set }
}

final class AuthorizationInteractor: NSObject, AuthorizationInteractorProtocol {
    
    fileprivate let dataManager: AuthorizationDataManagerInputProtocol
    fileprivate let authValidation: AuthValidationProtocol
    internal weak var interactorOutput: AuthorizationInteractorOutputProtocol?
    
    internal var textFieldDelegate: AuthTextFieldDelegateProtocol
    
    init(dataManager: AuthorizationDataManagerInputProtocol,
         authValidation: AuthValidationProtocol,
         textFieldDelegate: AuthTextFieldDelegateProtocol) {
        
        self.dataManager = dataManager
        self.authValidation = authValidation
        self.textFieldDelegate = textFieldDelegate
        
        super.init()
        subscribe()
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - AuthorizationDataManagerOutputProtocol
extension AuthorizationInteractor {
    
}

// MARK: - AuthorizationInteractorInputProtocol
extension AuthorizationInteractor {
    
    // Actions //
    
    func nicknameTextFieldEditingDidChangeAction(_ text: String?) {
        dataManager.setNickname(text)
    }
    
    func passwordTextFieldEditingDidChangeAction(_ text: String?) {
        dataManager.setPassword(text)
    }
    
    func loginButtonClicked() {
        interactorOutput?.hideKeyboard()
        authValidationRouting()        
    }
    
    // End Actions //
}

// MARK: - Subscribe
fileprivate extension AuthorizationInteractor {
    
    func subscribe() {
        nicknameTextFieldShouldReturnActionSubscribe()
        passwordTextFieldShouldReturnActionSubscribe()
    }
    
    func nicknameTextFieldShouldReturnActionSubscribe() {
        textFieldDelegate.nicknameTextFieldShouldReturnAction = { [weak self] in
            self?.interactorOutput?.makePasswordFieldActive()
        }
    }
    
    func passwordTextFieldShouldReturnActionSubscribe() {
        textFieldDelegate.passwordTextFieldShouldReturnAction = { [weak self] in
            self?.interactorOutput?.hideKeyboard()
            self?.authValidationRouting()
        }
    }
    
}

// MARK: - Auth Validation Routing
fileprivate extension AuthorizationInteractor {
   
    func authValidationRouting() {
        if (authValidation.isValid) {
            interactorOutput?.showCourseList()
        } else {
            interactorOutput?.showValidationError(authValidation.validationErrors.first!)
        }
    }
    
}
