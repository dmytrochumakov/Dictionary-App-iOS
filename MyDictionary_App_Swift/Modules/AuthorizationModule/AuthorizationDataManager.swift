//
//  AuthorizationDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 12.08.2021.

import Foundation

protocol AuthorizationDataManagerInputProtocol {
    func setNickname(_ text: String?)
    func setPassword(_ text: String?)
}

protocol AuthorizationDataManagerOutputProtocol: AnyObject {
    
}

protocol AuthorizationDataManagerProtocol: AuthorizationDataManagerInputProtocol {
    var dataProvider: AuthorizationDataProviderProtocol { get }
    var dataManagerOutput: AuthorizationDataManagerOutputProtocol? { get set }
}

final class AuthorizationDataManager: AuthorizationDataManagerProtocol {
    
    internal var dataProvider: AuthorizationDataProviderProtocol
    internal weak var dataManagerOutput: AuthorizationDataManagerOutputProtocol?
    
    init(dataProvider: AuthorizationDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension AuthorizationDataManager {
    
    func setNickname(_ text: String?) {
        dataProvider.nickname = text
    }
    
    func setPassword(_ text: String?) {        
        dataProvider.password = text
    }
    
}
