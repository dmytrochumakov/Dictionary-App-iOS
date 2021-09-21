//
//  AccountPresenter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 21.09.2021.

import UIKit

protocol AccountPresenterInputProtocol {
    
}

protocol AccountPresenterOutputProtocol: AnyObject {
    
}

protocol AccountPresenterProtocol: AccountPresenterInputProtocol,
AccountInteractorOutputProtocol {
    var presenterOutput: AccountPresenterOutputProtocol? { get set }
}

final class AccountPresenter: NSObject, AccountPresenterProtocol {
    
    fileprivate let interactor: AccountInteractorInputProtocol
    fileprivate let router: AccountRouterProtocol
    
    internal weak var presenterOutput: AccountPresenterOutputProtocol?
    
    init(interactor: AccountInteractorInputProtocol,
         router: AccountRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init()
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - AccountInteractorOutputProtocol
extension AccountPresenter {
    
}
