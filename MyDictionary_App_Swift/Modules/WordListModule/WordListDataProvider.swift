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
    var filteredWords: [WordResponse] { get set }
    
    func wordListCellModel(atIndexPath indexPath: IndexPath) -> MDWordListCellModel?
    
}

final class WordListDataProvider: WordListDataProviderProcotol {
    
    var course: CourseResponse
    var filteredWords: [WordResponse]
    
    init(course: CourseResponse,
         words: [WordResponse]) {
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
    
}
