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
                self?.dataProvider.sections = self?.configuredSections(byLanguages: languages) ?? []
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
                self?.dataProvider.sections = self?.filteredLanguages(input: readLanguages,
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
                // Set Sections
                self?.dataProvider.sections = self?.configuredSections(byLanguages: languages) ?? []
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

// MARK: - Private Methods
fileprivate extension AddCourseDataManager {
    
    func filteredLanguages(input array: [LanguageResponse],
                           searchText: String?) -> [MDAddCourseSection] {
        if (MDConstants.Text.textIsEmpty(searchText)) {
            return configuredSections(byLanguages: array)
        } else {
            return configuredSections(byLanguages: array.filter({ $0.languageName.lowercased().contains(searchText!.lowercased()) }))
        }
    }
    
    func sortAlphabeticallyLanguages(_ array: [LanguageResponse]) -> [LanguageResponse] {
        return array.sorted(by: { $0.languageName.localizedCaseInsensitiveCompare($1.languageName) == ComparisonResult.orderedAscending })
    }
    
    func configuredSections(byLanguages languages: [LanguageResponse]) -> [MDAddCourseSection] {
        
        if (languages.isEmpty) {
            return .init()
        } else {
            
            var result: [MDAddCourseSection] = .init()
            
            let sortedLanguages: [LanguageResponse] = sortAlphabeticallyLanguages(languages)
            
            MDConstants.EnglishAlphabet.uppercasedCharacters.forEach { character in
                
                result.append(.init(character: character,
                                    rows: configuredRows(sortedLanguages: sortedLanguages, character:
                                                            character)))
                
            }
            
            return result
            
        }
        
    }
    
    func configuredRows(sortedLanguages: [LanguageResponse], character: String) -> [LanguageResponse] {
        return sortedLanguages.filter({ String($0.languageName.first!).contains(character)})
    }
    
}
