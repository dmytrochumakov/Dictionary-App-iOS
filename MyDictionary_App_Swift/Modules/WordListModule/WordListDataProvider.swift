//
//  WordListDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import Foundation

protocol WordListDataProviderProcotol: MDNumberOfSectionsProtocol,
                                       MDNumberOfRowsInSectionProtocol {
    
    var course: MDCourseListModel { get }
    
    var availableWords: [CDWordEntity] { get set }
    var wordsForUse: [CDWordEntity] { get set }
    
    func wordListCellModel(atIndexPath indexPath: IndexPath) -> MDWordListCellModel?
    
    func addWord(newWord: CDWordEntity)
    func deleteWord(atIndexPath indexPath: IndexPath)
    func updateWord(atIndexPath indexPath: IndexPath, updatedWord: CDWordEntity)
    
}

final class WordListDataProvider: WordListDataProviderProcotol {
    
    var course: MDCourseListModel
    
    var availableWords: [CDWordEntity]
    var wordsForUse: [CDWordEntity]
    
    init(course: MDCourseListModel,
         availableWords: [CDWordEntity],
         wordsForUse: [CDWordEntity]) {
        
        self.course = course
        self.availableWords = availableWords
        self.wordsForUse = wordsForUse
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension WordListDataProvider {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return wordsForUse.count
    }
    
}

extension WordListDataProvider {
    
    func wordListCellModel(atIndexPath indexPath: IndexPath) -> MDWordListCellModel? {
        if (wordsForUse.isEmpty) {
            return nil
        } else {
            return .init(wordResponse: wordsForUse[indexPath.row])
        }
    }
    
}

extension WordListDataProvider {
    
    func addWord(newWord: CDWordEntity) {
        availableWords.insert(newWord, at: .zero)
        wordsForUse.insert(newWord, at: .zero)
    }
    
    func deleteWord(atIndexPath indexPath: IndexPath) {
        availableWords.remove(at: indexPath.row)
        wordsForUse.remove(at: indexPath.row)
    }
    
    func updateWord(atIndexPath indexPath: IndexPath, updatedWord: CDWordEntity) {
        availableWords[indexPath.row] = updatedWord
        wordsForUse[indexPath.row] = updatedWord
    }
    
}
