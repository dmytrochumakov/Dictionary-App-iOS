//
//  MDCourseStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

protocol MDCourseStorageProtocol {
    func entitiesIsEmpty(storageType: MDStorageType,
                         _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDEntitiesIsEmptyResultWithoutCompletion>))
    
    func entitiesCount(storageType: MDStorageType,
                       _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDEntitiesCountResultWithoutCompletion>))
    
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

final class MDCourseStorage: MDCourseStorageProtocol {
    
    fileprivate let memoryStorage: MDCourseMemoryStorageProtocol
    fileprivate let coreDataStorage: MDCourseCoreDataStorageProtocol
    
    init(memoryStorage: MDCourseMemoryStorageProtocol,
         coreDataStorage: MDCourseCoreDataStorageProtocol) {
        
        self.memoryStorage = memoryStorage
        self.coreDataStorage = coreDataStorage
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Entities
extension MDCourseStorage {
    
    func entitiesCount(storageType: MDStorageType, _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDEntitiesCountResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.entitiesCount { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.entitiesCount { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDEntitiesCountResultWithoutCompletion> = []
            
            // Check in Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.entitiesCount() { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Check in Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.entitiesCount() { result in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Notify And Pass Final Result
            dispatchGroup.notify(queue: .main) {
                completionHandler(finalResult)
            }
            
        }
        
    }
    
    func entitiesIsEmpty(storageType: MDStorageType, _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDEntitiesIsEmptyResultWithoutCompletion>)) {
     
        switch storageType {
        
        case .memory:
            
            memoryStorage.entitiesIsEmpty { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.entitiesIsEmpty { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDEntitiesIsEmptyResultWithoutCompletion> = []
            
            // Check in Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.entitiesIsEmpty() { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Check in Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.entitiesIsEmpty() { result in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Notify And Pass Final Result
            dispatchGroup.notify(queue: .main) {
                completionHandler(finalResult)
            }
            
        }
        
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
