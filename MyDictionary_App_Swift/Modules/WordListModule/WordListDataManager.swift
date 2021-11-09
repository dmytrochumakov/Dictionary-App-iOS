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
    func addWord(_ newValue: CDWordEntity) -> IndexPath
    func deleteWord(atWordResponse word: CDWordEntity) -> IndexPath
    func updateWord(atWordResponse word: CDWordEntity) -> IndexPath
    
}

protocol WordListDataManagerOutputProtocol: AnyObject {
    func readAndAddWordsToDataProviderResult(_ result: MDOperationResultWithoutCompletion<Void>)
    func filteredWordsResult(_ result: MDOperationResultWithoutCompletion<Void>)
    func clearWordFilterResult(_ result: MDOperationResultWithoutCompletion<Void>)
}

protocol WordListDataManagerProtocol: WordListDataManagerInputProtocol {
    var dataManagerOutput: WordListDataManagerOutputProtocol? { get set }
}

final class WordListDataManager: WordListDataManagerProtocol {
    
    fileprivate let coreDataStorage: MDWordCoreDataStorageProtocol
    fileprivate let filterSearchTextService: MDFilterSearchTextServiceProtocol
    
    internal var dataProvider: WordListDataProviderProcotol
    internal weak var dataManagerOutput: WordListDataManagerOutputProtocol?
    
    init(dataProvider: WordListDataProviderProcotol,
         coreDataStorage: MDWordCoreDataStorageProtocol,
         filterSearchTextService: MDFilterSearchTextServiceProtocol) {
        
        self.dataProvider = dataProvider
        self.coreDataStorage = coreDataStorage
        self.filterSearchTextService = filterSearchTextService
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - WordListDataManagerInputProtocol
extension WordListDataManager: WordListDataManagerInputProtocol {
    
    func readAndAddWordsToDataProvider() {
        
        coreDataStorage.readAllWords(byCourseUUID: dataProvider.course.course.uuid!,
                                     ascending: false) { [unowned self] result in
            
            switch result {
                
            case .success(let readWords):
                
                DispatchQueue.main.async {
                    
                    // Set Words
                    self.dataProvider.availableWords = readWords
                    self.dataProvider.wordsForUse = readWords
                    //
                    
                    // Pass Result
                    self.dataManagerOutput?.readAndAddWordsToDataProviderResult(.success(()))
                    //
                    
                }
                
                //
                break
                //
                
            case .failure(let error):
                
                DispatchQueue.main.async {
                    
                    // Pass Result
                    self.dataManagerOutput?.readAndAddWordsToDataProviderResult(.failure(error))
                    //
                    
                }
                
                //
                break
                //
                
            }
            
        }
        
    }
    
    func filterWords(_ searchText: String?) {
        
        filterSearchTextService.filter(input: self.dataProvider.availableWords,
                                       searchText: searchText) { [unowned self] (filteredResult) in
            
            DispatchQueue.main.async {
                
                // Set Filtered Result
                self.dataProvider.wordsForUse = filteredResult as! [CDWordEntity]
                //
                
                // Pass Result
                self.dataManagerOutput?.filteredWordsResult(.success(()))
                //
                
            }
            
        }
        
    }
    
    func clearWordFilter() {
        
        //
        self.dataProvider.wordsForUse = self.dataProvider.availableWords
        //
        
        // Pass Result
        self.dataManagerOutput?.clearWordFilterResult(.success(()))
        //
        
    }
    
    func deleteWord(atIndexPath indexPath: IndexPath) {
        dataProvider.deleteWord(atIndexPath: indexPath)
    }
    
    func addWord(_ newValue: CDWordEntity) -> IndexPath {
        //
        self.dataProvider.availableWords.insert(newValue, at: .zero)
        self.dataProvider.wordsForUse.insert(newValue, at: .zero)
        //
        return .init(row: .zero, section: section)
    }
    
    func deleteWord(atWordResponse word: CDWordEntity) -> IndexPath {
        //
        let row = dataProvider.wordsForUse.firstIndex(where: { $0.uuid == word.uuid })!
        let indexPath: IndexPath = .init(row: row,
                                         section: section)
        // Delete Word
        deleteWord(atIndexPath: indexPath)
        //
        return indexPath
    }
    
    func updateWord(atWordResponse word: CDWordEntity) -> IndexPath {
        //
        let row = dataProvider.wordsForUse.firstIndex(where: { $0.uuid == word.uuid })!
        let indexPath: IndexPath = .init(row: row,
                                         section: section)
        // Update Word
        dataProvider.updateWord(atIndexPath: indexPath,
                                updatedWord: word)
        //
        return indexPath
    }
    
}

// MARK: - Private Methods
fileprivate extension WordListDataManager {
    
    var section: Int {
        return .zero
    }
    
}
