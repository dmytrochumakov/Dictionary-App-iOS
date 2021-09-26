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
    var words: [WordResponse] { get set }
    
}

final class WordListDataProvider: WordListDataProviderProcotol {
    
    var course: CourseResponse
    var words: [WordResponse]
    
    init(course: CourseResponse, words: [WordResponse]) {
        self.course = course
        self.words = words
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
        return 0
    }
    
}
