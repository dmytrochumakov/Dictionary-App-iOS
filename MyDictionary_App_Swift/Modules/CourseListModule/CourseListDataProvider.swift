//
//  CourseListDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 11.08.2021.

import Foundation

protocol CourseListDataProviderProtocol: NumberOfSectionsProtocol,
                                         NumberOfRowsInSectionProtocol {
    
    var courses: [CourseResponse] { get set }
    
    func courseListCellModel(atIndexPath indexPath: IndexPath) -> CourseListCellModel?
    
}

final class CourseListDataProvider: CourseListDataProviderProtocol {
    
    var courses: [CourseResponse]
    
    init(courses: [CourseResponse]) {
        self.courses = courses
    }
    
}

extension CourseListDataProvider {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return courses.count
    }
        
    
}

extension CourseListDataProvider {
    
    func courseListCellModel(atIndexPath indexPath: IndexPath) -> CourseListCellModel? {
        
        if (courses.isEmpty) {
            return nil
        } else {
            return .init(languageName: courses[indexPath.row].languageName)
        }
        
    }
    
}
