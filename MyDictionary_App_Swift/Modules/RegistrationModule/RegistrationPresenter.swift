//
//  RegistrationPresenter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 14.08.2021.

import UIKit

protocol RegistrationPresenterInputProtocol {
    var textFieldDelegate: UITextFieldDelegate { get }    
    func registerButtonClicked()
    func nicknameTextFieldEditingDidChangeAction(_ text: String?)
    func passwordTextFieldEditingDidChangeAction(_ text: String?)
    func confirmPasswordTextFieldEditingDidChangeAction(_ text: String?)
}

protocol RegistrationPresenterOutputProtocol: AnyObject {
    func updateNicknameFieldCounter(_ count: Int)
    func makePasswordFieldActive()
    func makeConfirmPasswordFieldActive()
    func hideKeyboard()
    func showValidationError(_ error: Error)
}

protocol RegistrationPresenterProtocol: RegistrationPresenterInputProtocol,
                                        RegistrationInteractorOutputProtocol {
    var presenterOutput: RegistrationPresenterOutputProtocol? { get set }
}

final class RegistrationPresenter: NSObject, RegistrationPresenterProtocol {
    
    fileprivate let interactor: RegistrationInteractorInputProtocol
    fileprivate let router: RegistrationRouterProtocol
    
    internal weak var presenterOutput: RegistrationPresenterOutputProtocol?
    
    init(interactor: RegistrationInteractorInputProtocol,
         router: RegistrationRouterProtocol) {
        
        self.interactor = interactor
        self.router = router
        
        super.init()
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - RegistrationInteractorOutputProtocol
extension RegistrationPresenter {
    
    func updateNicknameFieldCounter(_ count: Int) {
        presenterOutput?.updateNicknameFieldCounter(count)
    }
    
    func makePasswordFieldActive() {
        presenterOutput?.makePasswordFieldActive()
    }
    
    func makeConfirmPasswordFieldActive() {
        presenterOutput?.makeConfirmPasswordFieldActive()
    }
    
    func hideKeyboard() {
        presenterOutput?.hideKeyboard()
    }
    
    func showValidationError(_ error: Error) {
        presenterOutput?.showValidationError(error)
    }
    
    func showCourseList() {
        router.showCourseList()
    }
    
}

// MARK: - RegistrationPresenterInputProtocol
extension RegistrationPresenter {
    
    var textFieldDelegate: UITextFieldDelegate {
        return interactor.textFieldDelegate
    }
    
    // Actions //
    func registerButtonClicked() {
        interactor.registerButtonClicked()
    }
    
    func nicknameTextFieldEditingDidChangeAction(_ text: String?) {
        interactor.nicknameTextFieldEditingDidChangeAction(text)
    }
    
    func passwordTextFieldEditingDidChangeAction(_ text: String?) {
        interactor.passwordTextFieldEditingDidChangeAction(text)
    }
    
    func confirmPasswordTextFieldEditingDidChangeAction(_ text: String?) {
        interactor.confirmPasswordTextFieldEditingDidChangeAction(text)
    }
    // End Actions //
    
}
