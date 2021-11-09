//
//  CourseListDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 11.08.2021.

import Foundation

protocol CourseListDataProviderProtocol: MDNumberOfSectionsProtocol,
                                         MDNumberOfRowsInSectionProtocol {
    
    var filteredCourses: [MDCourseListModel] { get set }
    
    func courseListCellModel(atIndexPath indexPath: IndexPath) -> MDCourseListCellModel?
    func course(atIndexPath indexPath: IndexPath) -> MDCourseListModel
    func deleteCourse(atIndexPath indexPath: IndexPath)
    
}

final class CourseListDataProvider: CourseListDataProviderProtocol {
    
    var filteredCourses: [MDCourseListModel]
    
    init(filteredCourses: [MDCourseListModel]) {
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
            let course = filteredCourses[indexPath.row]
            return .init(languageName: course.language.name,
                         translatedLanguageName: course.language.translatedName)
        }
        
    }
    
    func deleteCourse(atIndexPath indexPath: IndexPath) {
        filteredCourses.remove(at: indexPath.row)
    }
    
    func course(atIndexPath indexPath: IndexPath) -> MDCourseListModel {
        return filteredCourses[indexPath.row]
    }
    
}
