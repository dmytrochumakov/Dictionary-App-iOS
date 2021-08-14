//
//  RegistrationInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 14.08.2021.

import UIKit

protocol RegistrationInteractorInputProtocol {
    
}

protocol RegistrationInteractorOutputProtocol: AnyObject {
    
}

protocol RegistrationInteractorProtocol: RegistrationInteractorInputProtocol,
                                         RegistrationDataManagerOutputProtocol {
    var interactorOutput: RegistrationInteractorOutputProtocol? { get set }
}

final class RegistrationInteractor: NSObject, RegistrationInteractorProtocol {

    fileprivate let dataManager: RegistrationDataManagerInputProtocol
    internal weak var interactorOutput: RegistrationInteractorOutputProtocol?
    
    init(dataManager: RegistrationDataManagerInputProtocol) {
        
        self.dataManager = dataManager
        
        super.init()
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - RegistrationDataManagerOutputProtocol
extension RegistrationInteractor {
    
}
