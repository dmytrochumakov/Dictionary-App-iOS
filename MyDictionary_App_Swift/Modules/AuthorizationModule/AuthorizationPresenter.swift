//
//  AuthorizationPresenter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 12.08.2021.

import UIKit

protocol AuthorizationPresenterInputProtocol {
    
}

protocol AuthorizationPresenterOutputProtocol: AnyObject {
    
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
    
}