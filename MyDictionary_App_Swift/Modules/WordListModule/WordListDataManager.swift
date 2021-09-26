//
//  WordListDataManager.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import Foundation

protocol WordListDataManagerInputProtocol {
    func readAndAddWordsToDataProvider()
}

protocol WordListDataManagerOutputProtocol: AnyObject {
    func readAndAddWordsToDataProviderResult(_ result: MDOperationResultWithoutCompletion<Void>)
}

protocol WordListDataManagerProtocol: WordListDataManagerInputProtocol {
    var dataProvider: WordListDataProviderProcotol { get }
    var dataManagerOutput: WordListDataManagerOutputProtocol? { get set }
}

final class WordListDataManager: WordListDataManagerProtocol {
    
    fileprivate let memoryStorage: MDWordMemoryStorageProtocol
    var dataProvider: WordListDataProviderProcotol
    
    internal weak var dataManagerOutput: WordListDataManagerOutputProtocol?
    
    init(dataProvider: WordListDataProviderProcotol,
         memoryStorage: MDWordMemoryStorageProtocol) {
        
        self.dataProvider = dataProvider
        self.memoryStorage = memoryStorage
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - WordListDataManagerInputProtocol
extension WordListDataManager {
    
    func readAndAddWordsToDataProvider() {
     
        memoryStorage.readAllWords { [unowned self] result in
            
            switch result {
                
            case .success(let words):
                //
                dataProvider.words = words
                //
                dataManagerOutput?.readAndAddWordsToDataProviderResult(.success(()))
                //
                break
                //
            case .failure(let error):
                //
                dataManagerOutput?.readAndAddWordsToDataProviderResult(.failure(error))
                //
                break
                //
            }
            
        }
        
    }
    
}
