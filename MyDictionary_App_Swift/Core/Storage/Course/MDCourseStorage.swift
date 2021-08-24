//
//  MDCourseStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

protocol MDCourseStorageProtocol: MDStorageProtocol {
    
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
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.createCourse(courseEntity) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.createCourse(courseEntity) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDCourseResultWithoutCompletion> = []
            
            // Create in Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.createCourse(courseEntity) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Create in Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.createCourse(courseEntity) { result in
                
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
    
    func readCourse(storageType: MDStorageType,
                    fromCourseId courseId: Int64,
                    _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDCourseResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.readCourse(fromCourseId: courseId) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
            
        case .coreData:
            
            coreDataStorage.readCourse(fromCourseId: courseId) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDCourseResultWithoutCompletion> = []
            
            // Read From Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.readCourse(fromCourseId: courseId) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Read From Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.readCourse(fromCourseId: courseId) { result in
                
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
    
    func readAllCourses(storageType: MDStorageType,
                        _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDCoursesResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.readAllCourses { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
            
        case .coreData:
            
            coreDataStorage.readAllCourses { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDCoursesResultWithoutCompletion> = []
            
            // Read From Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.readAllCourses { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Read From Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.readAllCourses { result in
                
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
    
    func deleteCourse(storageType: MDStorageType,
                      fromCourseId courseId: Int64,
                      _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDCourseDeleteResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.deleteCourse(fromCourseId: courseId) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.deleteCourse(fromCourseId: courseId) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDDeleteAllEntitiesResultWithoutCompletion> = []
            
            // Delete From Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.deleteCourse(fromCourseId: courseId) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Delete From Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.deleteCourse(fromCourseId: courseId) { result in
                
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
    
    func deleteAllCourses(storageType: MDStorageType,
                          _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDDeleteAllEntitiesResultWithoutCompletion>)) {
        
        switch storageType {
        
        case .memory:
            
            memoryStorage.deleteAllCourses { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .coreData:
            
            coreDataStorage.deleteAllCourses { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            
        case .all:
            
            // Initialize Dispatch Group
            let dispatchGroup: DispatchGroup = .init()
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDDeleteAllEntitiesResultWithoutCompletion> = []
            
            // Delete From Memory
            // Dispatch Group Enter
            dispatchGroup.enter()
            memoryStorage.deleteAllCourses { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                // Dispatch Group Leave
                dispatchGroup.leave()
                
            }
            
            // Delete From Core Data
            // Dispatch Group Enter
            dispatchGroup.enter()
            coreDataStorage.deleteAllCourses { result in
                
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
