//
//  AuthorizationPresenter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 12.08.2021.

import UIKit

protocol AuthorizationPresenterInputProtocol {
    var textFieldDelegate: UITextFieldDelegate { get }
    func loginButtonClicked()
    func registerButtonClicked()
    func nicknameTextFieldEditingDidChangeAction(_ text: String?)
    func passwordTextFieldEditingDidChangeAction(_ text: String?)
}

protocol AuthorizationPresenterOutputProtocol: AnyObject {
    func makePasswordFieldActive()
    func hideKeyboard()
    func showValidationError(_ error: Error)
}

protocol AuthorizationPresenterProtocol: AuthorizationPresenterInputProtocol,
                                         AuthorizationInteractorOutputProtocol {
    var presenterOutput: AuthorizationPresenterOutputProtocol? { get set }
}

final class AuthorizationPresenter: NSObject, AuthorizationPresenterProtocol {
    
    fileprivate let interactor: AuthorizationInteractorInputProtocol
    fileprivate let router: AuthorizationRouterProtocol
    
    internal weak var presenterOutput: AuthorizationPresenterOutputProtocol?
    
    init(interactor: AuthorizationInteractorInputProtocol,
         router: AuthorizationRouterProtocol) {
        
        self.interactor = interactor
        self.router = router
        
        super.init()
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - AuthorizationInteractorOutputProtocol
extension AuthorizationPresenter {
    
    func makePasswordFieldActive() {
        presenterOutput?.makePasswordFieldActive()
    }
    
    func hideKeyboard() {
        presenterOutput?.hideKeyboard()
    }
    
    func showCourseList() {
        router.showCourseList()
    }
    
    func showRegistration() {
        router.showRegistration()
    }
    
    func showValidationError(_ error: Error) {
        presenterOutput?.showValidationError(error)
    }
    
}

// MARK: - AuthorizationPresenterInputProtocol
extension AuthorizationPresenter {
    
    var textFieldDelegate: UITextFieldDelegate {
        return interactor.textFieldDelegate
    }
    
    // Actions //
    func loginButtonClicked() {
        interactor.loginButtonClicked()
    }
    
    func registerButtonClicked() {
        interactor.registerButtonClicked()
    }
    
    func nicknameTextFieldEditingDidChangeAction(_ text: String?) {
        interactor.nicknameTextFieldEditingDidChangeAction(text)
    }
    
    func passwordTextFieldEditingDidChangeAction(_ text: String?) {
        interactor.passwordTextFieldEditingDidChangeAction(text)
    }
    // End Actions //
    
}
