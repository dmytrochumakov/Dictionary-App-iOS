//
//  AuthorizationInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 12.08.2021.

import UIKit

protocol AuthorizationInteractorInputProtocol {
    
}

protocol AuthorizationInteractorOutputProtocol: AnyObject {
    
}

protocol AuthorizationInteractorProtocol: AuthorizationInteractorInputProtocol,
                                          AuthorizationDataManagerOutputProtocol {
    var interactorOutput: AuthorizationInteractorOutputProtocol? { get set }
}

final class AuthorizationInteractor: AuthorizationInteractorProtocol {

    fileprivate let dataManager: AuthorizationDataManagerInputProtocol
    internal weak var interactorOutput: AuthorizationInteractorOutputProtocol?
    
    init(dataManager: AuthorizationDataManagerInputProtocol) {
        self.dataManager = dataManager
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - AuthorizationDataManagerOutputProtocol
extension AuthorizationInteractor {
    
}
