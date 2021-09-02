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
    func registerButtonClicked()
}

protocol AuthorizationInteractorOutputProtocol: AnyObject {
    func makePasswordFieldActive()
    func hideKeyboard()
    func showCourseList()
    func showRegistration()
    func showValidationError(_ error: Error)
}

protocol AuthorizationInteractorProtocol: AuthorizationInteractorInputProtocol,
                                          AuthorizationDataManagerOutputProtocol {
    var interactorOutput: AuthorizationInteractorOutputProtocol? { get set }
}

final class AuthorizationInteractor: NSObject, AuthorizationInteractorProtocol {
    
    fileprivate let dataManager: AuthorizationDataManagerInputProtocol
    fileprivate let authValidation: AuthValidationProtocol
    fileprivate let authManager: MDAuthManagerProtocol
    
    internal weak var interactorOutput: AuthorizationInteractorOutputProtocol?
    
    internal var textFieldDelegate: AuthTextFieldDelegateProtocol
    
    init(dataManager: AuthorizationDataManagerInputProtocol,
         authValidation: AuthValidationProtocol,
         textFieldDelegate: AuthTextFieldDelegateProtocol,
         authManager: MDAuthManagerProtocol) {
        
        self.dataManager = dataManager
        self.authValidation = authValidation
        self.textFieldDelegate = textFieldDelegate
        self.authManager = authManager
        
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
        authValidationAndRouting()
    }
    
    func registerButtonClicked() {
        interactorOutput?.hideKeyboard()
        interactorOutput?.showRegistration()
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
            self?.authValidationAndRouting()
        }
    }
    
}

// MARK: - Auth Validation And Routing
fileprivate extension AuthorizationInteractor {
    
    func authValidationAndRouting() {
        
        if (authValidation.isValid) {
            
            authManager.login(authRequest: .init(nickname: dataManager.getNickname()!,
                                                 password: dataManager.getPassword()!)) { [weak self] progress in
                
                debugPrint(#function, Self.self, "progress: ", progress)
                
            } completionHandler: { [weak self] (result) in
                
                switch result {
                case .success:
                    
                    self?.interactorOutput?.showCourseList()
                    break
                    
                case .failure(let error):
                    
                    self?.interactorOutput?.showValidationError(error)
                    break
                    
                }
                
            }
            
        } else {
            interactorOutput?.showValidationError(authValidation.validationErrors.first!)
        }
        
    }
    
}
