//
//  AccountDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 21.09.2021.

import Foundation

protocol AccountDataManagerInputProtocol {
    
}

protocol AccountDataManagerOutputProtocol: AnyObject {
    
}

protocol AccountDataManagerProtocol: AccountDataManagerInputProtocol {
    var dataProvider: AccountDataProviderProtocol { get }
    var dataManagerOutput: AccountDataManagerOutputProtocol? { get set }
}

final class AccountDataManager: AccountDataManagerProtocol {
    
    internal let dataProvider: AccountDataProviderProtocol
    internal weak var dataManagerOutput: AccountDataManagerOutputProtocol?
    
    init(dataProvider: AccountDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
