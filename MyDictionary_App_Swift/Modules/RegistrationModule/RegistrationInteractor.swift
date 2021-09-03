//
//  RegistrationInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 14.08.2021.

import UIKit

protocol RegistrationInteractorInputProtocol {
    var textFieldDelegate: AuthTextFieldDelegateProtocol { get }
    func nicknameTextFieldEditingDidChangeAction(_ text: String?)
    func passwordTextFieldEditingDidChangeAction(_ text: String?)    
    func registerButtonClicked()
}

protocol RegistrationInteractorOutputProtocol: AnyObject {
    func makePasswordFieldActive()
    func hideKeyboard()    
    func showValidationError(_ error: Error)
    func showCourseList()
}

protocol RegistrationInteractorProtocol: RegistrationInteractorInputProtocol,
                                         RegistrationDataManagerOutputProtocol {
    var interactorOutput: RegistrationInteractorOutputProtocol? { get set }
}

final class RegistrationInteractor: NSObject, RegistrationInteractorProtocol {
    
    fileprivate let dataManager: RegistrationDataManagerInputProtocol
    fileprivate let authValidation: AuthValidationProtocol
    fileprivate let apiManager: MDAuthManagerProtocol
    
    internal weak var interactorOutput: RegistrationInteractorOutputProtocol?
    
    internal var textFieldDelegate: AuthTextFieldDelegateProtocol
    
    init(dataManager: RegistrationDataManagerInputProtocol,
         authValidation: AuthValidationProtocol,
         textFieldDelegate: AuthTextFieldDelegateProtocol,
         apiManager: MDAuthManagerProtocol) {
        
        self.dataManager = dataManager
        self.authValidation = authValidation
        self.textFieldDelegate = textFieldDelegate
        self.apiManager = apiManager
        
        super.init()
        subscribe()
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - RegistrationDataManagerOutputProtocol
extension RegistrationInteractor {
    
}

// MARK: - AuthorizationInteractorInputProtocol
extension RegistrationInteractor {
    
    // Actions //
    
    func nicknameTextFieldEditingDidChangeAction(_ text: String?) {
        dataManager.setNickname(text)
    }
    
    func passwordTextFieldEditingDidChangeAction(_ text: String?) {
        dataManager.setPassword(text)
    }
    
    func registerButtonClicked() {
        interactorOutput?.hideKeyboard()
        authValidationAndRouting()
    }
    
    // End Actions //
}

// MARK: - Subscribe
fileprivate extension RegistrationInteractor {
    
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
fileprivate extension RegistrationInteractor {
    
    func authValidationAndRouting() {
        
        if (authValidation.isValid) {
            
            let authRequest: AuthRequest = .init(nickname: dataManager.getNickname()!,
                                                 password: dataManager.getPassword()!)
            
            apiManager.register(authRequest: authRequest) { [weak self] progress in
                
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
