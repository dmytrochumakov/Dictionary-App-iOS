//
//  CourseListDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 11.08.2021.

import Foundation

protocol CourseListDataProviderProtocol: MDNumberOfSectionsProtocol,
                                         MDNumberOfRowsInSectionProtocol {
    
    var availableCourses: [MDCourseListModel] { get set }
    var coursesForUse: [MDCourseListModel] { get set }
    
    func courseListCellModel(atIndexPath indexPath: IndexPath) -> MDCourseListCellModel?
    func course(atIndexPath indexPath: IndexPath) -> MDCourseListModel
    
    func addCourse(_ newValue: MDCourseListModel)
    func deleteCourse(atIndexPath indexPath: IndexPath)
    
}

final class CourseListDataProvider: CourseListDataProviderProtocol {
    
    var availableCourses: [MDCourseListModel]
    var coursesForUse: [MDCourseListModel]
    
    init(availableCourses: [MDCourseListModel],
         coursesForUse: [MDCourseListModel]) {
        
        self.availableCourses = availableCourses
        self.coursesForUse = coursesForUse
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension CourseListDataProvider {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return coursesForUse.count
    }
    
}

extension CourseListDataProvider {
    
    func courseListCellModel(atIndexPath indexPath: IndexPath) -> MDCourseListCellModel? {
        
        if (coursesForUse.isEmpty) {
            return nil
        } else {
            let course = coursesForUse[indexPath.row]
            return .init(languageName: course.language.name,
                         translatedLanguageName: course.language.translatedName)
        }
        
    }
    
    func course(atIndexPath indexPath: IndexPath) -> MDCourseListModel {
        return coursesForUse[indexPath.row]
    }
    
}

extension CourseListDataProvider {
    
    func addCourse(_ newValue: MDCourseListModel) {
        availableCourses.insert(newValue, at: .zero)
        coursesForUse.insert(newValue, at: .zero)
    }
    
    func deleteCourse(atIndexPath indexPath: IndexPath) {
        availableCourses.remove(at: indexPath.row)
        coursesForUse.remove(at: indexPath.row)
    }
    
}
