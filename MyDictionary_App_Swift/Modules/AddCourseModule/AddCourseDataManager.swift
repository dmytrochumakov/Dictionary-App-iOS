//
//  AddCourseDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 23.09.2021.

import Foundation

protocol AddCourseDataManagerInputProtocol {
    func loadAndPassLanguagesArrayToDataProvider()
}

protocol AddCourseDataManagerOutputProtocol: AnyObject {
    func loadAndPassLanguagesArrayToDataProviderResult(_ completionHandler: MDOperationResultWithoutCompletion<Void>)
}

protocol AddCourseDataManagerProtocol: AddCourseDataManagerInputProtocol {
    var dataProvider: AddCourseDataProviderProtocol { get }
    var dataManagerOutput: AddCourseDataManagerOutputProtocol? { get set }
}

final class AddCourseDataManager: AddCourseDataManagerProtocol {
    
    fileprivate let languageMemoryStorage: MDLanguageMemoryStorageProtocol
    
    internal var dataProvider: AddCourseDataProviderProtocol
    internal weak var dataManagerOutput: AddCourseDataManagerOutputProtocol?
    
    init(languageMemoryStorage: MDLanguageMemoryStorageProtocol,
         dataProvider: AddCourseDataProviderProtocol) {
        self.languageMemoryStorage = languageMemoryStorage
        self.dataProvider = dataProvider
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension AddCourseDataManager {
    
    func loadAndPassLanguagesArrayToDataProvider() {
        
        languageMemoryStorage.readAllLanguages { [weak self] readResult in
            
            switch readResult {
                
            case .success(let languages):
                // Set Languages
                self?.dataProvider.languages = languages
                // Pass Result
                self?.dataManagerOutput?.loadAndPassLanguagesArrayToDataProviderResult(.success(()))
                //
                break
                
            case .failure(let error):
                // Pass Result
                self?.dataManagerOutput?.loadAndPassLanguagesArrayToDataProviderResult(.failure(error))
                //
                break
            }
            
        }
        
    }
    
}

