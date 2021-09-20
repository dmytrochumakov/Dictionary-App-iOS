//
//  AuthenticationPresenter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 12.08.2021.

import UIKit

protocol AuthenticationPresenterInputProtocol {
    var textFieldDelegate: UITextFieldDelegate { get }
    func loginButtonClicked()
    func registerButtonClicked()
    func nicknameTextFieldEditingDidChangeAction(_ text: String?)
    func passwordTextFieldEditingDidChangeAction(_ text: String?)
}

protocol AuthenticationPresenterOutputProtocol: AnyObject,
                                                MDShowHideUpdateProgressHUD {
    
    func makePasswordFieldActive()
    func hideKeyboard()
    func showValidationError(_ error: Error)
    
}

protocol AuthenticationPresenterProtocol: AuthenticationPresenterInputProtocol,
                                          AuthenticationInteractorOutputProtocol {
    var presenterOutput: AuthenticationPresenterOutputProtocol? { get set }
}

final class AuthenticationPresenter: NSObject, AuthenticationPresenterProtocol {
    
    fileprivate let interactor: AuthenticationInteractorInputProtocol
    fileprivate let router: AuthenticationRouterProtocol
    
    internal weak var presenterOutput: AuthenticationPresenterOutputProtocol?
    
    init(interactor: AuthenticationInteractorInputProtocol,
         router: AuthenticationRouterProtocol) {
        
        self.interactor = interactor
        self.router = router
        
        super.init()
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - AuthenticationInteractorOutputProtocol
extension AuthenticationPresenter {
    
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
    
    func showProgressHUD() {
        presenterOutput?.showProgressHUD()
    }
    
    func hideProgressHUD() {
        presenterOutput?.hideProgressHUD()
    }
    
    func updateHUDProgress(_ progress: Float) {
        presenterOutput?.updateHUDProgress(progress)
    }
    
}

// MARK: - AuthenticationPresenterInputProtocol
extension AuthenticationPresenter {
    
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
