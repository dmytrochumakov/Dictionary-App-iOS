//
//  ChoiceAuthenticationOrRegistrationPresenter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 10.09.2021.

import UIKit

protocol ChoiceAuthenticationOrRegistrationPresenterInputProtocol {
    func loginButtonClicked()
    func registrationButtonClicked()
}

protocol ChoiceAuthenticationOrRegistrationPresenterOutputProtocol: AnyObject {
    
}

protocol ChoiceAuthenticationOrRegistrationPresenterProtocol: ChoiceAuthenticationOrRegistrationPresenterInputProtocol,
ChoiceAuthenticationOrRegistrationInteractorOutputProtocol {
    var presenterOutput: ChoiceAuthenticationOrRegistrationPresenterOutputProtocol? { get set }
}

final class ChoiceAuthenticationOrRegistrationPresenter: NSObject,
                                                         ChoiceAuthenticationOrRegistrationPresenterProtocol {
    
    fileprivate let interactor: ChoiceAuthenticationOrRegistrationInteractorInputProtocol
    fileprivate let router: ChoiceAuthenticationOrRegistrationRouterProtocol
    
    internal weak var presenterOutput: ChoiceAuthenticationOrRegistrationPresenterOutputProtocol?
    
    init(interactor: ChoiceAuthenticationOrRegistrationInteractorInputProtocol,
         router: ChoiceAuthenticationOrRegistrationRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init()
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - ChoiceAuthenticationOrRegistrationInteractorOutputProtocol
extension ChoiceAuthenticationOrRegistrationPresenter {
    
    func showAuthentication() {
        router.showAuthentication()
    }
    
    func showRegistration() {
        router.showRegistration()
    }
    
}

// MARK: - ChoiceAuthenticationOrRegistrationPresenterInputProtocol
extension ChoiceAuthenticationOrRegistrationPresenter {
    
    func loginButtonClicked() {
        interactor.loginButtonClicked()
    }
    
    func registrationButtonClicked() {
        interactor.registrationButtonClicked()
    }
    
}
