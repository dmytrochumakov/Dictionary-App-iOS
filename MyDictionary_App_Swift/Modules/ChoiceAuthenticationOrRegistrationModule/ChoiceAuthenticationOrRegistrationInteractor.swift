//
//  ChoiceAuthenticationOrRegistrationInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 10.09.2021.

import UIKit

protocol ChoiceAuthenticationOrRegistrationInteractorInputProtocol {
    
}

protocol ChoiceAuthenticationOrRegistrationInteractorOutputProtocol: AnyObject {
    
}

protocol ChoiceAuthenticationOrRegistrationInteractorProtocol: ChoiceAuthenticationOrRegistrationInteractorInputProtocol, ChoiceAuthenticationOrRegistrationDataManagerOutputProtocol {
    var interactorOutput: ChoiceAuthenticationOrRegistrationInteractorOutputProtocol? { get set }
}

final class ChoiceAuthenticationOrRegistrationInteractor: ChoiceAuthenticationOrRegistrationInteractorProtocol {

    fileprivate let dataManager: ChoiceAuthenticationOrRegistrationDataManagerInputProtocol
    internal weak var interactorOutput: ChoiceAuthenticationOrRegistrationInteractorOutputProtocol?
    
    init(dataManager: ChoiceAuthenticationOrRegistrationDataManagerInputProtocol) {
        self.dataManager = dataManager
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - ChoiceAuthenticationOrRegistrationDataManagerOutputProtocol
extension ChoiceAuthenticationOrRegistrationInteractor {
    
}
