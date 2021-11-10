//
//  AddCourseDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 23.09.2021.

import Foundation

protocol AddCourseDataProviderProtocol: MDNumberOfSectionsProtocol,
                                        MDNumberOfRowsInSectionProtocol {
    
    var availableSections: [MDAddCourseSection] { get }
    var sectionsForUse: [MDAddCourseSection] { get set }
    func addCourseHeaderViewCellModel(atSection section: Int) -> MDAddCourseHeaderViewCellModel?
    func addCourseRow(atIndexPath indexPath: IndexPath) -> MDAddCourseRow?
    func addCourseCellModels(atSection section: Int) -> [MDAddCourseRow]
    
}

final class AddCourseDataProvider: AddCourseDataProviderProtocol {
    
    let availableSections: [MDAddCourseSection]
    var sectionsForUse: [MDAddCourseSection]
    
    init(availableSections: [MDAddCourseSection],
         sectionsForUse: [MDAddCourseSection]) {
        
        self.availableSections = availableSections
        self.sectionsForUse = sectionsForUse
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension AddCourseDataProvider {
    
    var numberOfSections: Int {
        return sectionsForUse.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return sectionsForUse[section].rows.count
    }
    
}

extension AddCourseDataProvider {
    
    func addCourseHeaderViewCellModel(atSection section: Int) -> MDAddCourseHeaderViewCellModel? {
        if (sectionsForUse.isEmpty) {
            return nil
        } else {
            return .init(character: sectionsForUse[section].character)
        }
    }
    
    func addCourseRow(atIndexPath indexPath: IndexPath) -> MDAddCourseRow? {
        if (sectionsForUse.isEmpty) {
            return nil
        } else {
            return sectionsForUse[indexPath.section].rows[indexPath.row]
        }
    }
    
    func addCourseCellModels(atSection section: Int) -> [MDAddCourseRow] {
        if (sectionsForUse.isEmpty) {
            return .init()
        } else {
            return sectionsForUse[section].rows
        }
    }
    
}
