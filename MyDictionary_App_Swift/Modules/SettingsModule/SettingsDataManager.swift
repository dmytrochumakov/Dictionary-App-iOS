//
//  SettingsDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 31.05.2021.

import Foundation

protocol SettingsDataManagerInputProtocol {
    
}

protocol SettingsDataManagerOutputProtocol: AnyObject {
    
}

protocol SettingsDataManagerProtocol: SettingsDataManagerInputProtocol {
    var dataProvider: SettingsDataProviderProtocol { get }
    var dataManagerOutput: SettingsDataManagerOutputProtocol? { get set }
}

final class SettingsDataManager: SettingsDataManagerProtocol {
    
    internal let dataProvider: SettingsDataProviderProtocol
    internal weak var dataManagerOutput: SettingsDataManagerOutputProtocol?
    
    init(dataProvider: SettingsDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
