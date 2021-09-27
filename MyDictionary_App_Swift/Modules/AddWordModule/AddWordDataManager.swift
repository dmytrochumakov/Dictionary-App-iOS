//
//  AddWordDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 27.09.2021.

import Foundation

protocol AddWordDataManagerInputProtocol {
    
}

protocol AddWordDataManagerOutputProtocol: AnyObject {
    
}

protocol AddWordDataManagerProtocol: AddWordDataManagerInputProtocol {
    var dataProvider: AddWordDataProviderProtocol { get }
    var dataManagerOutput: AddWordDataManagerOutputProtocol? { get set }
}

final class AddWordDataManager: AddWordDataManagerProtocol {
    
    internal let dataProvider: AddWordDataProviderProtocol
    internal weak var dataManagerOutput: AddWordDataManagerOutputProtocol?
    
    init(dataProvider: AddWordDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
