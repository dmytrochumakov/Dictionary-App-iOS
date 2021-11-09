//
//  AddCourseDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 23.09.2021.

import Foundation

protocol AddCourseDataManagerInputProtocol {
    var selectedRow: MDAddCourseRow? { get }
    func loadAndPassLanguagesArrayToDataProvider()
    func filterLanguages(_ searchText: String?)
    func clearLanguageFilter()
    func selectAndDeselectRow(_ newValue: MDAddCourseRow) -> [Bool : IndexPath]
}

protocol AddCourseDataManagerOutputProtocol: AnyObject {
    func loadAndPassLanguagesArrayToDataProviderResult(_ completionHandler: MDOperationResultWithoutCompletion<Void>)
    func filteredLanguagesResult(_ result: MDOperationResultWithoutCompletion<Void>)
    func clearLanguageFilterResult(_ result: MDOperationResultWithoutCompletion<Void>)
}

protocol AddCourseDataManagerProtocol: AddCourseDataManagerInputProtocol {
    var dataManagerOutput: AddCourseDataManagerOutputProtocol? { get set }
}

final class AddCourseDataManager: AddCourseDataManagerProtocol {
    
    fileprivate var dataProvider: AddCourseDataProviderProtocol
    fileprivate let languageMemoryStorage: MDLanguageMemoryStorageProtocol
    fileprivate let filterSearchTextService: MDFilterSearchTextServiceProtocol
    
    var selectedRow: MDAddCourseRow? {
        guard let selectedIndexPath = self.firstSelectedIndexPath else { return nil }
        return dataProvider.sections[selectedIndexPath.section].rows[selectedIndexPath.row]
    }
    
    internal weak var dataManagerOutput: AddCourseDataManagerOutputProtocol?
    
    init(dataProvider: AddCourseDataProviderProtocol,
         languageMemoryStorage: MDLanguageMemoryStorageProtocol,
         filterSearchTextService: MDFilterSearchTextServiceProtocol) {
        
        self.dataProvider = dataProvider
        self.languageMemoryStorage = languageMemoryStorage
        self.filterSearchTextService = filterSearchTextService
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension AddCourseDataManager {
    
    func loadAndPassLanguagesArrayToDataProvider() {
        
        // Configure Sections
        dataProvider.sections = configuredSections(byLanguages: languageMemoryStorage.readAllLanguages())
        //
        
        // Pass Result
        dataManagerOutput?.loadAndPassLanguagesArrayToDataProviderResult(.success(()))
        //
        
    }
    
    func filterLanguages(_ searchText: String?) {
        
        filterSearchTextService.filter(input: languageMemoryStorage.readAllLanguages(),
                                       searchText: searchText) { [unowned self] (filteredResult) in
            
            DispatchQueue.main.async {
                
                // Set Filtered Result
                self.dataProvider.sections = configuredSections(byLanguages: filteredResult as! [MDLanguageModel])
                //
                
                // Pass Result
                self.dataManagerOutput?.filteredLanguagesResult(.success(()))
                //
                
            }
            
        }
        
    }
    
    func clearLanguageFilter() {
        
        // Configure Sections
        dataProvider.sections = configuredSections(byLanguages: languageMemoryStorage.readAllLanguages())
        //
        
        // Pass Result
        dataManagerOutput?.clearLanguageFilterResult(.success(()))
        //
        
    }
    
    func selectAndDeselectRow(_ newValue: MDAddCourseRow) -> [Bool : IndexPath] {
        
        var result: [Bool : IndexPath] = [:]
        
        if (self.firstSelectedIndexPath == nil) {
            //
            let newSelectedIndexPath = newSelectedIndexPath(fromSelectedRow: newValue)
            //
            self.dataProvider.sections[newSelectedIndexPath.section].rows[newSelectedIndexPath.row].isSelected = true
            //
            result.updateValue(newSelectedIndexPath, forKey: true)
            //
            return result
            //
        } else {
            //
            let oldSelectedIndexPath = self.firstSelectedIndexPath!
            let newSelectedIndexPath = self.newSelectedIndexPath(fromSelectedRow: newValue)
            //
            if (oldSelectedIndexPath == newSelectedIndexPath) {
                return result
            } else {
                //
                self.dataProvider.sections[oldSelectedIndexPath.section].rows[oldSelectedIndexPath.row].isSelected = false
                //
                result.updateValue(oldSelectedIndexPath, forKey: false)
                //
                self.dataProvider.sections[newSelectedIndexPath.section].rows[newSelectedIndexPath.row].isSelected = true
                //
                result.updateValue(newSelectedIndexPath, forKey: true)
                //
                return result
            }
            //
        }
        
    }
    
}

// MARK: - Private Methods
fileprivate extension AddCourseDataManager {
    
    func sortAlphabeticallyLanguages(_ array: [MDLanguageModel]) -> [MDLanguageModel] {
        return array.sorted(by: { $0.name.localizedCaseInsensitiveCompare($1.name) == ComparisonResult.orderedAscending })
    }
    
    func configuredSections(byLanguages languages: [MDLanguageModel]) -> [MDAddCourseSection] {
        
        if (languages.isEmpty) {
            return .init()
        } else {
            
            var result: [MDAddCourseSection] = .init()
            
            let sortedLanguages: [MDLanguageModel] = sortAlphabeticallyLanguages(languages)
            
            MDConstants.EnglishAlphabet.uppercasedCharacters.forEach { character in
                
                result.append(.init(character: character,
                                    rows: configuredRows(sortedLanguages: sortedLanguages,
                                                         character: character)))
                
            }
            
            return result
            
        }
        
    }
    
    func configuredRows(sortedLanguages: [MDLanguageModel], character: String) -> [MDAddCourseRow] {
        
        var result: [MDAddCourseRow] = .init()
        
        sortedLanguages
            .filter({ String($0.name.first!).contains(character)})
            .forEach { languageResponse in
                
                result.append(.init(languageResponse: languageResponse,
                                    isSelected: false))
                
            }
        
        return result
        
    }
    
    var firstSelectedIndexPath: IndexPath? {
        guard let sectionIndex = dataProvider.sections.firstIndex(where: { $0.rows.contains(where: { $0.isSelected }) }) else { return (nil) }
        guard let rowIndex = dataProvider.sections[sectionIndex].rows.firstIndex(where: { $0.isSelected }) else { return (nil) }
        return .init(row: rowIndex, section: sectionIndex)
    }
    
    func newSelectedIndexPath(fromSelectedRow row: MDAddCourseRow) -> IndexPath {
        let sectionIndex = dataProvider.sections.firstIndex(where: { $0.rows.contains(where: { $0 == row }) })!
        let rowIndex = dataProvider.sections[sectionIndex].rows.firstIndex(where: { $0 == row })!
        return .init(row: rowIndex, section: sectionIndex)
    }
    
}
