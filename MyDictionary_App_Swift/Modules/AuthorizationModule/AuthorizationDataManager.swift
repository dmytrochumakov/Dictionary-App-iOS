//
//  AuthorizationDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 12.08.2021.

import Foundation

protocol AuthorizationDataManagerInputProtocol {
    
}

protocol AuthorizationDataManagerOutputProtocol: AnyObject {
    
}

protocol AuthorizationDataManagerProtocol: AuthorizationDataManagerInputProtocol {
    var dataProvider: AuthorizationDataProviderProtocol { get }
    var dataManagerOutput: AuthorizationDataManagerOutputProtocol? { get set }
}

final class AuthorizationDataManager: AuthorizationDataManagerProtocol {
    
    internal let dataProvider: AuthorizationDataProviderProtocol
    internal weak var dataManagerOutput: AuthorizationDataManagerOutputProtocol?
    
    init(dataProvider: AuthorizationDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
