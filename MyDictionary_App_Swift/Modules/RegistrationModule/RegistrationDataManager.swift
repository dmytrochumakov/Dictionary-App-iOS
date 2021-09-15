//
//  RegistrationDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 14.08.2021.

import Foundation

protocol RegistrationDataManagerInputProtocol {
    func getNickname() -> String?
    func getPassword() -> String?
    func getConfirmPassword() -> String?
    func setNickname(_ text: String?)
    func setPassword(_ text: String?)
    func setConfirmPassword(_ text: String?)
}

protocol RegistrationDataManagerOutputProtocol: AnyObject {
    
}

protocol RegistrationDataManagerProtocol: RegistrationDataManagerInputProtocol {
    var dataProvider: RegistrationDataProviderProtocol { get }
    var dataManagerOutput: RegistrationDataManagerOutputProtocol? { get set }
}

final class RegistrationDataManager: RegistrationDataManagerProtocol {
    
    internal var dataProvider: RegistrationDataProviderProtocol
    internal weak var dataManagerOutput: RegistrationDataManagerOutputProtocol?
    
    init(dataProvider: RegistrationDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension RegistrationDataManager {
    
    func getNickname() -> String? {
        return dataProvider.nickname
    }
    
    func getPassword() -> String? {
        return dataProvider.password
    }
    
    func getConfirmPassword() -> String? {
        return dataProvider.confirmPassword
    }
    
    func setNickname(_ text: String?) {
        dataProvider.nickname = text
    }
    
    func setPassword(_ text: String?) {
        dataProvider.password = text
    }
    
    func setConfirmPassword(_ text: String?) {
        dataProvider.confirmPassword = text
    }
    
}
