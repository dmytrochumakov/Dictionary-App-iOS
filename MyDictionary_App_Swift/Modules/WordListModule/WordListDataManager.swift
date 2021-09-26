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
        
        memoryStorage.readAllWords(byCourseID: dataProvider.course.courseId) { [unowned self] result in
            
            switch result {
                
            case .success(let words):
                // Set Sections
                dataProvider.sections = configuredSections(byWords: words)
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
    
}

// MARK: - Private Methods
fileprivate extension WordListDataManager {
    
    func configuredSections(byWords words: [WordResponse]) -> [MDWordListSection] {
        
        if (words.isEmpty) {
            return .init()
        } else {
            
            var result: [MDWordListSection] = .init()
            
            let sortedWords: [WordResponse] = sortAlphabeticallyWords(words)
            
            MDConstants.EnglishAlphabet.uppercasedCharacters.forEach { character in
                
                result.append(.init(character: character,
                                    rows: configuredRows(sortedWords: sortedWords,
                                                         character: character)))
                
            }
            
            return result
            
        }
        
    }
    
    func configuredRows(sortedWords: [WordResponse], character: String) -> [MDWordListRow] {
        
        var result: [MDWordListRow] = .init()
        
        sortedWords
            .filter({ String($0.wordText.first!).contains(character)})
            .forEach { wordResponse in
                
                result.append(.init(wordResponse: wordResponse,
                                    isSelected: false))
                
            }
        
        return result
        
    }
    
    func sortAlphabeticallyWords(_ array: [WordResponse]) -> [WordResponse] {
        return array.sorted(by: { $0.wordText.localizedCaseInsensitiveCompare($1.wordText) == ComparisonResult.orderedAscending })
    }
    
}
