//
//  PrivacyPolicyInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 21.09.2021.

import UIKit

protocol PrivacyPolicyInteractorInputProtocol {
    
}

protocol PrivacyPolicyInteractorOutputProtocol: AnyObject {
    
}

protocol PrivacyPolicyInteractorProtocol: PrivacyPolicyInteractorInputProtocol,
                                            PrivacyPolicyDataManagerOutputProtocol {
    var interactorOutput: PrivacyPolicyInteractorOutputProtocol? { get set }
}

final class PrivacyPolicyInteractor: PrivacyPolicyInteractorProtocol {

    fileprivate let dataManager: PrivacyPolicyDataManagerInputProtocol
    internal weak var interactorOutput: PrivacyPolicyInteractorOutputProtocol?
    
    init(dataManager: PrivacyPolicyDataManagerInputProtocol) {
        self.dataManager = dataManager
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - PrivacyPolicyDataManagerOutputProtocol
extension PrivacyPolicyInteractor {
    
}
