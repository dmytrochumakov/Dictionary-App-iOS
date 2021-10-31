//
//  MDCourseManager.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 20.09.2021.
//

import Foundation

protocol MDCourseManagerProtocol {
    
    func addCourse(byLanguage language: LanguageResponse,
                   _ completionHandler: @escaping(MDOperationResultWithCompletion<CourseResponse>))
    
    func deleteCourseFromApiAndAllStorage(byCourseId courseId: Int64,
                                          _ completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
    
}

final class MDCourseManager: MDCourseManagerProtocol {
        
    fileprivate let apiCourse: MDAPICourseProtocol
    fileprivate let courseStorage: MDCourseStorageProtocol
    fileprivate let wordStorage: MDWordStorageProtocol
    
    init(apiCourse: MDAPICourseProtocol,
         courseStorage: MDCourseStorageProtocol,
         wordStorage: MDWordStorageProtocol) {
                
        self.apiCourse = apiCourse
        self.courseStorage = courseStorage
        self.wordStorage = wordStorage
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDCourseManager {
    
    func addCourse(byLanguage language: LanguageResponse,
                   _ completionHandler: @escaping(MDOperationResultWithCompletion<CourseResponse>)) {
       
    }
    
}

extension MDCourseManager {
    
    func deleteCourseFromApiAndAllStorage(byCourseId courseId: Int64,
                                          _ completionHandler: @escaping(MDOperationResultWithCompletion<Void>)) {
        
       
    }
    
}
