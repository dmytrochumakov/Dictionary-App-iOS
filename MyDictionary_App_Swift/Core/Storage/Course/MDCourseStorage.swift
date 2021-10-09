//
//  MDCourseStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

protocol MDCourseStorageProtocol: MDStorageProtocol {
    
    var memoryStorage: MDCourseMemoryStorageProtocol { get }
    
    func createCourse(storageType: MDStorageType,
                      courseEntity: CourseResponse,
                      _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<CourseResponse>>))
    
    func createCourses(storageType: MDStorageType,
                       courseEntities: [CourseResponse],
                       _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationsResultWithoutCompletion<CourseResponse>>))
    
    func readCourse(storageType: MDStorageType,
                    fromCourseId courseId: Int64,
                    _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<CourseResponse>>))
    
    func readAllCourses(storageType: MDStorageType,
                        _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationsResultWithoutCompletion<CourseResponse>>))
    
    func deleteCourse(storageType: MDStorageType,
                      fromCourseId courseId: Int64,
                      _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>))
    
    func deleteAllCourses(storageType: MDStorageType,
                          _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>))
}

final class MDCourseStorage: MDStorage, MDCourseStorageProtocol {
    
    let memoryStorage: MDCourseMemoryStorageProtocol
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
                      courseEntity: CourseResponse,
                      _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<CourseResponse>>)) {
        
        switch storageType {
            
        case .memory:
            
            //
            self.memoryStorage.createCourse(courseEntity) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .coreData:
            
            //
            self.coreDataStorage.createCourse(courseEntity) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .all:
            
            //
            let countNeeded: Int = 2
            //
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<CourseResponse>> = []
            
            // Create in Memory
            self.memoryStorage.createCourse(courseEntity) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    completionHandler(finalResult)
                }
                
            }
            
            // Create in Core Data
            self.coreDataStorage.createCourse(courseEntity) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    completionHandler(finalResult)
                }
                //
                
            }
            
            //
            break
            //
            
        }
        
    }
    
    func createCourses(storageType: MDStorageType,
                       courseEntities: [CourseResponse],
                       _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationsResultWithoutCompletion<CourseResponse>>)) {
        
        debugPrint(#function, Self.self, "Start")
        
        switch storageType {
            
        case .memory:
            
            //
            self.memoryStorage.createCourses(courseEntities) { result in
                debugPrint(#function, Self.self, "memory -> with result:", result)
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .coreData:
            
            //
            self.coreDataStorage.createCourses(courseEntities) { result in
                debugPrint(#function, Self.self, "coredata -> with result:", result)
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .all:
            
            //
            let countNeeded: Int = 2
            //
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationsResultWithoutCompletion<CourseResponse>> = []
            
            // Create in Memory
            self.memoryStorage.createCourses(courseEntities) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    debugPrint(#function, Self.self, "all -> memory -> with result:", result)
                    completionHandler(finalResult)
                }
                //
                
                
            }
            
            // Create in Core Data
            self.coreDataStorage.createCourses(courseEntities) { result in
                
                // Append Result
                
                finalResult.append(.init(storageType: .coreData, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    debugPrint(#function, Self.self, "all -> coredata -> with result:", result)
                    completionHandler(finalResult)
                }
                //
                
            }
            
            //
            break
            //
            
        }
        
    }
    
    func readCourse(storageType: MDStorageType,
                    fromCourseId courseId: Int64,
                    _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<CourseResponse>>)) {
        
        switch storageType {
            
        case .memory:
            
            //
            self.memoryStorage.readCourse(fromCourseId: courseId) { result in
                completionHandler([.init(storageType: storageType, result: result)])
                //
            }
            
            //
            break
            //
            
        case .coreData:
            
            //
            self.coreDataStorage.readCourse(fromCourseId: courseId) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .all:
            
            //
            let countNeeded: Int = 2
            //
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<CourseResponse>> = []
            
            // Read From Memory
            self.memoryStorage.readCourse(fromCourseId: courseId) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    completionHandler(finalResult)
                }
                //
                
            }
            
            // Read From Core Data
            self.coreDataStorage.readCourse(fromCourseId: courseId) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    completionHandler(finalResult)
                }
                //
                
            }
            
            //
            break
            //
            
        }
        
    }
    
    func readAllCourses(storageType: MDStorageType,
                        _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationsResultWithoutCompletion<CourseResponse>>)) {
        
        switch storageType {
            
        case .memory:
            
            //
            self.memoryStorage.readAllCourses { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .coreData:
            
            //
            self.coreDataStorage.readAllCourses { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .all:
            
            //
            let countNeeded: Int = 2
            //
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationsResultWithoutCompletion<CourseResponse>> = []
            
            // Read From Memory
            self.memoryStorage.readAllCourses { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    completionHandler(finalResult)
                }
                //
                
            }
            
            // Read From Core Data
            self.coreDataStorage.readAllCourses { result in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    completionHandler(finalResult)
                }
                //
                
            }
            
            //
            break
            //
            
        }
        
    }
    
    func deleteCourse(storageType: MDStorageType,
                      fromCourseId courseId: Int64,
                      _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>)) {
        
        switch storageType {
            
        case .memory:
            
            //
            self.memoryStorage.deleteCourse(fromCourseId: courseId) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .coreData:
            
            //
            self.coreDataStorage.deleteCourse(fromCourseId: courseId) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .all:
            
            //
            let countNeeded: Int = 2
            //
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<Void>> = []
            
            // Delete From Memory
            self.memoryStorage.deleteCourse(fromCourseId: courseId) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    completionHandler(finalResult)
                }
                //
                
            }
            
            // Delete From Core Data
            self.coreDataStorage.deleteCourse(fromCourseId: courseId) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    completionHandler(finalResult)
                }
                //
                
            }
            
            //
            break
            //
            
        }
        
    }
    
    func deleteAllCourses(storageType: MDStorageType,
                          _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>)) {
        
        switch storageType {
            
        case .memory:
            
            //
            self.memoryStorage.deleteAllCourses { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .coreData:
            
            //
            self.coreDataStorage.deleteAllCourses { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .all:
            
            //
            let countNeeded: Int = 2
            //
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<Void>> = []
            
            // Delete From Memory
            self.memoryStorage.deleteAllCourses { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    completionHandler(finalResult)
                }
                //
                
            }
            
            // Delete From Core Data
            self.coreDataStorage.deleteAllCourses { result in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    completionHandler(finalResult)
                }
                //
                
            }
            
            //
            break
            //
            
        }
        
    }
    
}
