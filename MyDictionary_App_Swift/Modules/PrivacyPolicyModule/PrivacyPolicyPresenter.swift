//
//  PrivacyPolicyPresenter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 21.09.2021.

import UIKit

protocol PrivacyPolicyPresenterInputProtocol {
    
}

protocol PrivacyPolicyPresenterOutputProtocol: AnyObject {
    
}

protocol PrivacyPolicyPresenterProtocol: PrivacyPolicyPresenterInputProtocol,
                                         PrivacyPolicyInteractorOutputProtocol {
    var presenterOutput: PrivacyPolicyPresenterOutputProtocol? { get set }
}

final class PrivacyPolicyPresenter: NSObject, PrivacyPolicyPresenterProtocol {
    
    fileprivate let interactor: PrivacyPolicyInteractorInputProtocol
    fileprivate let router: PrivacyPolicyRouterProtocol
    
    internal weak var presenterOutput: PrivacyPolicyPresenterOutputProtocol?
    
    init(interactor: PrivacyPolicyInteractorInputProtocol,
         router: PrivacyPolicyRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init()
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - PrivacyPolicyInteractorOutputProtocol
extension PrivacyPolicyPresenter {
    
}
