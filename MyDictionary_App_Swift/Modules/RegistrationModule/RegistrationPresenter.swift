//
//  RegistrationPresenter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 14.08.2021.

import UIKit

protocol RegistrationPresenterInputProtocol {
    
}

protocol RegistrationPresenterOutputProtocol: AnyObject {
    
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
    
}
