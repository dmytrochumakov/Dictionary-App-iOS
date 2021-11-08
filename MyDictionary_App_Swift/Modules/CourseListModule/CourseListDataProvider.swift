//
//  CourseListDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 11.08.2021.

import Foundation

protocol CourseListDataProviderProtocol: MDNumberOfSectionsProtocol,
                                         MDNumberOfRowsInSectionProtocol {
    
    var filteredCourses: [CDCourseEntity] { get set }
    
    func courseListCellModel(atIndexPath indexPath: IndexPath) -> MDCourseListCellModel?
    func course(atIndexPath indexPath: IndexPath) -> CDCourseEntity
    func deleteCourse(atIndexPath indexPath: IndexPath)
    
}

final class CourseListDataProvider: CourseListDataProviderProtocol {
    
    var filteredCourses: [CDCourseEntity]
    
    init(filteredCourses: [CDCourseEntity]) {
        self.filteredCourses = filteredCourses
    }
    
}

extension CourseListDataProvider {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return filteredCourses.count
    }
        
}

extension CourseListDataProvider {
    
    func courseListCellModel(atIndexPath indexPath: IndexPath) -> MDCourseListCellModel? {
        
        if (filteredCourses.isEmpty) {
            return nil
        } else {
            return .init(languageName: filteredCourses[indexPath.row].uuid!.uuidString)
        }
        
    }
    
    func deleteCourse(atIndexPath indexPath: IndexPath) {
        filteredCourses.remove(at: indexPath.row)
    }
    
    func course(atIndexPath indexPath: IndexPath) -> CDCourseEntity {
        return filteredCourses[indexPath.row]
    }
    
}
