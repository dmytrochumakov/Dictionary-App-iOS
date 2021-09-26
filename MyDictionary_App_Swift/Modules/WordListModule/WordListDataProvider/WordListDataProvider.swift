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
    
}

final class WordListDataProvider: WordListDataProviderProcotol {
    
    var course: CourseResponse
    
    init(course: CourseResponse) {
        self.course = course
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
