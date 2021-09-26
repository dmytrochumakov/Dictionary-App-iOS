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
    var sections: [MDWordListSection] { get set }
    
    func row(atIndexPath indexPath: IndexPath) -> MDWordListRow?
    
}

final class WordListDataProvider: WordListDataProviderProcotol {
    
    var course: CourseResponse
    var sections: [MDWordListSection]
    
    init(course: CourseResponse,
         sections: [MDWordListSection]) {
        self.course = course
        self.sections = sections
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension WordListDataProvider {
    
    var numberOfSections: Int {
        return sections.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return sections[section].rows.count
    }
    
}

extension WordListDataProvider {
    
    func row(atIndexPath indexPath: IndexPath) -> MDWordListRow? {
        if (sections.isEmpty) {
            return nil
        } else {
            return sections[indexPath.section].rows[indexPath.row]
        }
    }
    
}
