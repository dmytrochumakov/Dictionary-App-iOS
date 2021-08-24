//
//  MDCourseStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

protocol MDCourseStorageProtocol {
        
    func createCourse(storageType: MDStorageType,
                      courseEntity: CourseEntity,
                      _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDCourseResultWithoutCompletion>))
    
    func readCourse(storageType: MDStorageType,
                    fromCourseId courseId: Int64,
                    _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDCourseResultWithoutCompletion>))
    
    func readAllCourses(storageType: MDStorageType,
                        _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDCoursesResultWithoutCompletion>))
    
    func deleteCourse(storageType: MDStorageType,
                      fromCourseId courseId: Int64,
                      _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDCourseDeleteResultWithoutCompletion>))
    
    func deleteAllCourses(storageType: MDStorageType,
                          _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDDeleteAllEntitiesResultWithoutCompletion>))
}

final class MDCourseStorage: MDStorage, MDCourseStorageProtocol {
    
    fileprivate let memoryStorage: MDCourseMemoryStorageProtocol
    fileprivate let coreDataStorage: MDCourseCoreDataStorageProtocol
    
    init(memoryStorage: MDCourseMemoryStorageProtocol,
         coreDataStorage: MDCourseCoreDataStorageProtocol) {
        
        self.memoryStorage = memoryStorage
        self.coreDataStorage = coreDataStorage
        
        super.init(memoryStorage: memoryStorage,
                   coreDataStorage: coreDataStorage)
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - CRUD
extension MDCourseStorage {
    
    func createCourse(storageType: MDStorageType,
                      courseEntity: CourseEntity,
                      _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDCourseResultWithoutCompletion>)) {
        
    }
    
    func readCourse(storageType: MDStorageType,
                    fromCourseId courseId: Int64,
                    _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDCourseResultWithoutCompletion>)) {
        
    }
    
    func readAllCourses(storageType: MDStorageType,
                        _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDCoursesResultWithoutCompletion>)) {
        
    }
    
    func deleteCourse(storageType: MDStorageType,
                      fromCourseId courseId: Int64,
                      _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDCourseDeleteResultWithoutCompletion>)) {
        
    }
    
    func deleteAllCourses(storageType: MDStorageType,
                          _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDDeleteAllEntitiesResultWithoutCompletion>)) {
        
    }
    
}
