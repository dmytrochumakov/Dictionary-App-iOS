//
//  WordListDataManager.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import Foundation

protocol WordListDataManagerInputProtocol {
    
}

protocol WordListDataManagerOutputProtocol: AnyObject {
    
}

protocol WordListDataManagerProtocol: WordListDataManagerInputProtocol {
    var dataProvider: WordListDataProviderProcotol { get }
    var dataManagerOutput: WordListDataManagerOutputProtocol? { get set }
}

final class WordListDataManager: WordListDataManagerProtocol {
    
    let dataProvider: WordListDataProviderProcotol
    internal weak var dataManagerOutput: WordListDataManagerOutputProtocol?
    
    init(dataProvider: WordListDataProviderProcotol) {
        self.dataProvider = dataProvider
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension WordListDataManager {
    
   
    
}
