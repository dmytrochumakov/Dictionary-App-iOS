//
//  AddCourseDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 23.09.2021.

import Foundation

protocol AddCourseDataManagerInputProtocol {
    func loadAndPassLanguagesArrayToDataProvider()
    func filterLanguages(_ searchText: String?)
    func clearLanguageFilter()
}

protocol AddCourseDataManagerOutputProtocol: AnyObject {
    func loadAndPassLanguagesArrayToDataProviderResult(_ completionHandler: MDOperationResultWithoutCompletion<Void>)
    func filteredLanguagesResult(_ result: MDOperationResultWithoutCompletion<Void>)
    func clearLanguageFilterResult(_ result: MDOperationResultWithoutCompletion<Void>)
}

protocol AddCourseDataManagerProtocol: AddCourseDataManagerInputProtocol {
    var dataProvider: AddCourseDataProviderProtocol { get }
    var dataManagerOutput: AddCourseDataManagerOutputProtocol? { get set }
}

final class AddCourseDataManager: AddCourseDataManagerProtocol {
    
    fileprivate let memoryStorage: MDLanguageMemoryStorageProtocol
    
    internal var dataProvider: AddCourseDataProviderProtocol
    internal weak var dataManagerOutput: AddCourseDataManagerOutputProtocol?
    
    init(memoryStorage: MDLanguageMemoryStorageProtocol,
         dataProvider: AddCourseDataProviderProtocol) {
        self.memoryStorage = memoryStorage
        self.dataProvider = dataProvider
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension AddCourseDataManager {
    
    func loadAndPassLanguagesArrayToDataProvider() {
        
        memoryStorage.readAllLanguages { [weak self] readResult in
            
            switch readResult {
                
            case .success(let languages):
                // Set Languages
                self?.dataProvider.filteredLanguages = languages
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
    
    func filterLanguages(_ searchText: String?) {
        
        memoryStorage.readAllLanguages { [weak self] readResult in
            
            switch readResult {
                
            case .success(let readLanguages):
                // Set Filtered Result
                self?.dataProvider.filteredLanguages = self?.filteredLanguages(input: readLanguages,
                                                                               searchText: searchText) ?? []
                // Pass Result
                self?.dataManagerOutput?.filteredLanguagesResult(.success(()))
                //
                break
                //
            case .failure(let error):
                // Pass Result
                self?.dataManagerOutput?.filteredLanguagesResult(.failure(error))
                //
                break
                //
            }
            
        }
        
    }
    
    func clearLanguageFilter() {
        
        memoryStorage.readAllLanguages { [weak self] readResult in
            
            switch readResult {
                
            case .success(let languages):
                // Set Languages
                self?.dataProvider.filteredLanguages = languages
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

fileprivate extension AddCourseDataManager {
    
    func filteredLanguages(input array: [LanguageResponse],
                           searchText: String?) -> [LanguageResponse] {
        if (MDConstants.Text.textIsEmpty(searchText)) {
            return array
        } else {
            return array.filter({ $0.languageName.lowercased().contains(searchText!.lowercased()) })
        }
    }
    
}
