//
//  AuthorizationInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 12.08.2021.

import UIKit

protocol AuthorizationInteractorInputProtocol {
    var textFieldDelegate: AuthTextFieldDelegateProtocol { get }
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
    
    internal var textFieldDelegate: AuthTextFieldDelegateProtocol
    
    init(dataManager: AuthorizationDataManagerInputProtocol,
         textFieldDelegate: AuthTextFieldDelegateProtocol) {
        
        self.dataManager = dataManager
        self.textFieldDelegate = textFieldDelegate
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - AuthorizationDataManagerOutputProtocol
extension AuthorizationInteractor {
    
}
