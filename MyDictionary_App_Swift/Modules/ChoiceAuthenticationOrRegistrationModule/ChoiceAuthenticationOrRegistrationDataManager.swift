//
//  ChoiceAuthenticationOrRegistrationDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 10.09.2021.

import Foundation

protocol ChoiceAuthenticationOrRegistrationDataManagerInputProtocol {
    
}

protocol ChoiceAuthenticationOrRegistrationDataManagerOutputProtocol: AnyObject {
    
}

protocol ChoiceAuthenticationOrRegistrationDataManagerProtocol: ChoiceAuthenticationOrRegistrationDataManagerInputProtocol {
    var dataProvider: ChoiceAuthenticationOrRegistrationDataProviderProtocol { get }
    var dataManagerOutput: ChoiceAuthenticationOrRegistrationDataManagerOutputProtocol? { get set }
}

final class ChoiceAuthenticationOrRegistrationDataManager: ChoiceAuthenticationOrRegistrationDataManagerProtocol {
    
    internal let dataProvider: ChoiceAuthenticationOrRegistrationDataProviderProtocol
    internal weak var dataManagerOutput: ChoiceAuthenticationOrRegistrationDataManagerOutputProtocol?
    
    init(dataProvider: ChoiceAuthenticationOrRegistrationDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
