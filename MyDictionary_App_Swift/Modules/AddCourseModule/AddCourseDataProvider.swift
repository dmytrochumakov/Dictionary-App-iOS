//
//  AddCourseDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 23.09.2021.

import Foundation

protocol AddCourseDataProviderProtocol: MDNumberOfSectionsProtocol,
                                        MDNumberOfRowsInSectionProtocol {
    
    var sections: [MDAddCourseSection] { get set }
    func addCourseHeaderViewCellModel(atSection section: Int) -> MDAddCourseHeaderViewCellModel?
    func addCourseRow(atIndexPath indexPath: IndexPath) -> MDAddCourseRow?
    func addCourseCellModels(atSection section: Int) -> [MDAddCourseRow]
    
}

final class AddCourseDataProvider: AddCourseDataProviderProtocol {
    
    var sections: [MDAddCourseSection]
    
    init(sections: [MDAddCourseSection]) {
        self.sections = sections
    }
    
}

extension AddCourseDataProvider {
    
    var numberOfSections: Int {
        return sections.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return sections[section].rows.count
    }
    
}

extension AddCourseDataProvider {
    
    func addCourseHeaderViewCellModel(atSection section: Int) -> MDAddCourseHeaderViewCellModel? {
        if (sections.isEmpty) {
            return nil
        } else {
            return .init(character: sections[section].character)
        }
    }
    
    func addCourseRow(atIndexPath indexPath: IndexPath) -> MDAddCourseRow? {
        if (sections.isEmpty) {
            return nil
        } else {
            return sections[indexPath.section].rows[indexPath.row]
        }
    }
    
    func addCourseCellModels(atSection section: Int) -> [MDAddCourseRow] {
        if (sections.isEmpty) {
            return .init()
        } else {
            return sections[section].rows
        }
    }
    
}
