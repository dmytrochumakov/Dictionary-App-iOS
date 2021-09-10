//
//  ChoiceAuthenticationOrRegistrationPresenter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 10.09.2021.

import UIKit

protocol ChoiceAuthenticationOrRegistrationPresenterInputProtocol {
    
}

protocol ChoiceAuthenticationOrRegistrationPresenterOutputProtocol: AnyObject {
    
}

protocol ChoiceAuthenticationOrRegistrationPresenterProtocol: ChoiceAuthenticationOrRegistrationPresenterInputProtocol,
ChoiceAuthenticationOrRegistrationInteractorOutputProtocol {
    var presenterOutput: ChoiceAuthenticationOrRegistrationPresenterOutputProtocol? { get set }
}

final class ChoiceAuthenticationOrRegistrationPresenter: NSObject, ChoiceAuthenticationOrRegistrationPresenterProtocol {
    
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
    
}
