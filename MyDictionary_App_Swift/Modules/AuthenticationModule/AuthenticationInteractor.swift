//
//  AuthenticationInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 12.08.2021.

import UIKit

protocol AuthenticationInteractorInputProtocol {
    var textFieldDelegate: AuthTextFieldDelegateProtocol { get }
    func nicknameTextFieldEditingDidChangeAction(_ text: String?)
    func passwordTextFieldEditingDidChangeAction(_ text: String?)
    func loginButtonClicked()
    func registerButtonClicked()
}

protocol AuthenticationInteractorOutputProtocol: AnyObject,
                                                 MDShowHideUpdateProgressHUD {
    
    func makePasswordFieldActive()
    func hideKeyboard()
    func showCourseList()
    func showRegistration()
    func showValidationError(_ error: Error)
    
}

protocol AuthenticationInteractorProtocol: AuthenticationInteractorInputProtocol,
                                           AuthenticationDataManagerOutputProtocol {
    var interactorOutput: AuthenticationInteractorOutputProtocol? { get set }
}

final class AuthenticationInteractor: NSObject, AuthenticationInteractorProtocol {
    
    fileprivate let dataManager: AuthenticationDataManagerInputProtocol
    fileprivate let authValidation: AuthValidationProtocol
    fileprivate let authManager: MDAuthManagerProtocol
    
    internal weak var interactorOutput: AuthenticationInteractorOutputProtocol?
    
    internal var textFieldDelegate: AuthTextFieldDelegateProtocol
    
    init(dataManager: AuthenticationDataManagerInputProtocol,
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

// MARK: - AuthenticationDataManagerOutputProtocol
extension AuthenticationInteractor {
    
}

// MARK: - AuthenticationInteractorInputProtocol
extension AuthenticationInteractor {
    
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
fileprivate extension AuthenticationInteractor {
    
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
fileprivate extension AuthenticationInteractor {
    
    func authValidationAndRouting() {
        
        if (authValidation.isValid) {
            
            // Show Progress HUD
            interactorOutput?.showProgressHUD()
            //
            authManager.login(authRequest: .init(nickname: dataManager.getNickname()!,
                                                 password: dataManager.getPassword()!)) { [weak self] progress in
                
                self?.interactorOutput?.updateHUDProgress(progress)
                
            } completionHandler: { [weak self] (result) in
                
                switch result {
                case .success:
                    
                    // Hide Progress HUD
                    self?.interactorOutput?.hideProgressHUD()
                    //
                    self?.interactorOutput?.showCourseList()
                    //
                    break
                    
                case .failure(let error):
                    
                    // Hide Progress HUD
                    self?.interactorOutput?.hideProgressHUD()
                    //
                    self?.interactorOutput?.showValidationError(error)
                    //
                    break
                    
                }
                
            }
            
        } else {
            interactorOutput?.showValidationError(authValidation.validationErrors.first!)
        }
        
    }
    
}
