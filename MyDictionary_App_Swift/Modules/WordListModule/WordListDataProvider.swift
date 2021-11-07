//
//  WordListDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import Foundation

protocol WordListDataProviderProcotol: MDNumberOfSectionsProtocol,
                                       MDNumberOfRowsInSectionProtocol {
    
    var course: CourseResponse { get }
    var filteredWords: [MDWordModel] { get set }
    
    func wordListCellModel(atIndexPath indexPath: IndexPath) -> MDWordListCellModel?
    func deleteWord(atIndexPath indexPath: IndexPath)
    func updateWord(atIndexPath indexPath: IndexPath, updatedWord: MDWordModel)
    
}

final class WordListDataProvider: WordListDataProviderProcotol {
    
    var course: CourseResponse
    var filteredWords: [MDWordModel]
    
    init(course: CourseResponse,
         words: [MDWordModel]) {
        self.course = course
        self.filteredWords = words
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
        return filteredWords.count
    }
    
}

extension WordListDataProvider {
    
    func wordListCellModel(atIndexPath indexPath: IndexPath) -> MDWordListCellModel? {
        if (filteredWords.isEmpty) {
            return nil
        } else {
            return .init(wordResponse: filteredWords[indexPath.row])
        }
    }
    
    func deleteWord(atIndexPath indexPath: IndexPath) {
        filteredWords.remove(at: indexPath.row)
    }
    
    func updateWord(atIndexPath indexPath: IndexPath, updatedWord: MDWordModel) {
        filteredWords[indexPath.row] = updatedWord
    }
    
}
