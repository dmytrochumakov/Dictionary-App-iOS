//
//  AppearanceDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 03.06.2021.

import Foundation

protocol AppearanceDataManagerInputProtocol {
    
}

protocol AppearanceDataManagerOutputProtocol: AnyObject {
    
}

protocol AppearanceDataManagerProtocol: AppearanceDataManagerInputProtocol {
    var dataProvider: AppearanceDataProviderProtocol { get }
    var dataManagerOutput: AppearanceDataManagerOutputProtocol? { get set }
}

final class AppearanceDataManager: AppearanceDataManagerProtocol {
    
    internal let dataProvider: AppearanceDataProviderProtocol
    internal weak var dataManagerOutput: AppearanceDataManagerOutputProtocol?
    
    init(dataProvider: AppearanceDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
