//
//  PrivacyPolicyDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 21.09.2021.

import Foundation

protocol PrivacyPolicyDataManagerInputProtocol {
    
}

protocol PrivacyPolicyDataManagerOutputProtocol: AnyObject {
    
}

protocol PrivacyPolicyDataManagerProtocol: PrivacyPolicyDataManagerInputProtocol {
    var dataProvider: PrivacyPolicyDataProviderProtocol { get }
    var dataManagerOutput: PrivacyPolicyDataManagerOutputProtocol? { get set }
}

final class PrivacyPolicyDataManager: PrivacyPolicyDataManagerProtocol {
    
    internal let dataProvider: PrivacyPolicyDataProviderProtocol
    internal weak var dataManagerOutput: PrivacyPolicyDataManagerOutputProtocol?
    
    init(dataProvider: PrivacyPolicyDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
