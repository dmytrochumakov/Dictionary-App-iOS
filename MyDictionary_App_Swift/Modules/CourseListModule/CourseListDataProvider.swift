//
//  CourseListDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 11.08.2021.

import Foundation

protocol CourseListDataProviderProtocol: NumberOfSectionsProtocol,
                                         NumberOfRowsInSectionProtocol {
    
    var filteredCourses: [CourseResponse] { get set }
    
    func courseListCellModel(atIndexPath indexPath: IndexPath) -> MDCourseListCellModel?
    func course(atIndexPath indexPath: IndexPath) -> CourseResponse
    func deleteCourse(atIndexPath indexPath: IndexPath)
    
}

final class CourseListDataProvider: CourseListDataProviderProtocol {
    
    var filteredCourses: [CourseResponse]
    
    init(filteredCourses: [CourseResponse]) {
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
            return .init(languageName: filteredCourses[indexPath.row].languageName)
        }
        
    }
    
    func deleteCourse(atIndexPath indexPath: IndexPath) {
        filteredCourses.remove(at: indexPath.row)
    }
    
    func course(atIndexPath indexPath: IndexPath) -> CourseResponse {
        return filteredCourses[indexPath.row]
    }
    
}
