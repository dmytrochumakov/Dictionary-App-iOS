//
//  AuthenticationDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 12.08.2021.

import Foundation

protocol AuthenticationDataManagerInputProtocol {
    func getNickname() -> String?
    func getPassword() -> String?
    func setNickname(_ text: String?)
    func setPassword(_ text: String?)
}

protocol AuthenticationDataManagerOutputProtocol: AnyObject {
    
}

protocol AuthenticationDataManagerProtocol: AuthenticationDataManagerInputProtocol {
    var dataProvider: AuthenticationDataProviderProtocol { get }
    var dataManagerOutput: AuthenticationDataManagerOutputProtocol? { get set }
}

final class AuthenticationDataManager: AuthenticationDataManagerProtocol {
    
    internal var dataProvider: AuthenticationDataProviderProtocol
    internal weak var dataManagerOutput: AuthenticationDataManagerOutputProtocol?
    
    init(dataProvider: AuthenticationDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension AuthenticationDataManager {
    
    func getNickname() -> String? {
        return dataProvider.nickname
    }
    
    func getPassword() -> String? {
        return dataProvider.password
    }
    
    func setNickname(_ text: String?) {
        dataProvider.nickname = text
    }
    
    func setPassword(_ text: String?) {        
        dataProvider.password = text
    }
    
}
