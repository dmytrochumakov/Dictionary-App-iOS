//
//  WordListDataManager.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import Foundation

protocol WordListDataManagerInputProtocol {
    var dataProvider: WordListDataProviderProcotol { get }
    func readAndAddWordsToDataProvider()
    func filterWords(_ searchText: String?)
    func clearWordFilter()
    func deleteWord(atIndexPath indexPath: IndexPath)
    func addWord(_ newValue: WordResponse) -> IndexPath
    func indexPath(atWordResponse word: WordResponse) -> IndexPath
}

protocol WordListDataManagerOutputProtocol: AnyObject {
    func readAndAddWordsToDataProviderResult(_ result: MDOperationResultWithoutCompletion<Void>)
    func filteredWordsResult(_ result: MDOperationResultWithoutCompletion<Void>)
    func clearWordFilterResult(_ result: MDOperationResultWithoutCompletion<Void>)
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
extension WordListDataManager: WordListDataManagerInputProtocol {
    
    func readAndAddWordsToDataProvider() {
        
        memoryStorage.readAllWords(byCourseID: dataProvider.course.courseId) { [unowned self] result in
            
            switch result {
                
            case .success(let words):
                // Set Words
                dataProvider.filteredWords = words
                // Pass Result
                dataManagerOutput?.readAndAddWordsToDataProviderResult(.success(()))
                //
                break
                //
            case .failure(let error):
                // Pass Result
                dataManagerOutput?.readAndAddWordsToDataProviderResult(.failure(error))
                //
                break
                //
            }
            
        }
        
    }
    
    func filterWords(_ searchText: String?) {
        
        memoryStorage.readAllWords(byCourseID: dataProvider.course.courseId) { [weak self] readResult in
            
            switch readResult {
                
            case .success(let readWords):
                // Set Filtered Result
                self?.dataProvider.filteredWords = self?.filteredWords(input: readWords,
                                                                       searchText: searchText) ?? []
                // Pass Result
                self?.dataManagerOutput?.filteredWordsResult(.success(()))
                //
                break
                //
            case .failure(let error):
                // Pass Result
                self?.dataManagerOutput?.filteredWordsResult(.failure(error))
                //
                break
                //
            }
            
        }
        
    }
    
    func clearWordFilter() {
        
        memoryStorage.readAllWords(byCourseID: dataProvider.course.courseId) { [weak self] readResult in
            
            switch readResult {
                
            case .success(let readWords):
                // Set Read Results
                self?.dataProvider.filteredWords = readWords
                // Pass Result
                self?.dataManagerOutput?.clearWordFilterResult(.success(()))
                //
                break
                //
            case .failure(let error):
                // Pass Result
                self?.dataManagerOutput?.clearWordFilterResult(.failure(error))
                //
                break
                //
            }
            
        }
        
    }
    
    func deleteWord(atIndexPath indexPath: IndexPath) {
        dataProvider.deleteWord(atIndexPath: indexPath)
    }
    
    func addWord(_ newValue: WordResponse) -> IndexPath {
        //
        self.dataProvider.filteredWords.append(newValue)
        //
        let row = (self.dataProvider.numberOfRowsInSection(section) - 1)
        //
        return .init(row: row, section: section)
    }
    
    func indexPath(atWordResponse word: WordResponse) -> IndexPath {
        return .init(row: dataProvider.filteredWords.firstIndex(where: { $0.wordId == word.wordId })!,
                     section: section)
    }
    
}

// MARK: - Private Methods
fileprivate extension WordListDataManager {
    
    var section: Int {
        return (self.dataProvider.numberOfSections - 1)
    }
    
    func filteredWords(input words: [WordResponse],
                       searchText: String?) -> [WordResponse] {
        if (MDConstants.Text.textIsEmpty(searchText)) {
            return words
        } else {
            return words.filter({ $0.wordText.lowercased().contains(searchText!.lowercased()) })
        }
    }
    
}
