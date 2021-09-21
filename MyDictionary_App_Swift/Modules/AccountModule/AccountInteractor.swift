//
//  AccountInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 21.09.2021.

import UIKit

protocol AccountInteractorInputProtocol {
    
}

protocol AccountInteractorOutputProtocol: AnyObject {
    
}

protocol AccountInteractorProtocol: AccountInteractorInputProtocol, AccountDataManagerOutputProtocol {
    var interactorOutput: AccountInteractorOutputProtocol? { get set }
}

final class AccountInteractor: AccountInteractorProtocol {

    fileprivate let dataManager: AccountDataManagerInputProtocol
    internal weak var interactorOutput: AccountInteractorOutputProtocol?
    
    init(dataManager: AccountDataManagerInputProtocol) {
        self.dataManager = dataManager
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - AccountDataManagerOutputProtocol
extension AccountInteractor {
    
}
