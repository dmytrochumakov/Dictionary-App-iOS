//
//  RegistrationDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 14.08.2021.

import Foundation

protocol RegistrationDataManagerInputProtocol {
    
}

protocol RegistrationDataManagerOutputProtocol: AnyObject {
    
}

protocol RegistrationDataManagerProtocol: RegistrationDataManagerInputProtocol {
    var dataProvider: RegistrationDataProviderProtocol { get }
    var dataManagerOutput: RegistrationDataManagerOutputProtocol? { get set }
}

final class RegistrationDataManager: RegistrationDataManagerProtocol {
    
    internal let dataProvider: RegistrationDataProviderProtocol
    internal weak var dataManagerOutput: RegistrationDataManagerOutputProtocol?
    
    init(dataProvider: RegistrationDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
