//
//  MDCourseMemoryStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

protocol MDCourseMemoryStorageProtocol: MDCRUDCourseProtocol,
                                        MDStorageInterface {
    
}

final class MDCourseMemoryStorage: MDCourseMemoryStorageProtocol {
    
    fileprivate let operationQueueService: OperationQueueServiceProtocol
    
    var array: [CourseEntity]
    
    init(operationQueueService: OperationQueueServiceProtocol,
         array: [CourseEntity]) {
        
        self.operationQueueService = operationQueueService
        self.array = array
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Entities
extension MDCourseMemoryStorage {
    
    func entitiesCount(_ completionHandler: @escaping (MDEntitiesCountResultWithCompletion)) {
        self.readAllCourses { result in
            switch result {
            case .success(let entities):
                completionHandler(.success(entities.count))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func entitiesIsEmpty(_ completionHandler: @escaping (MDEntitiesIsEmptyResultWithCompletion)) {
        self.readAllCourses { result in
            switch result {
            case .success(let entities):
                completionHandler(.success(entities.isEmpty))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}

// MARK: - CRUD
extension MDCourseMemoryStorage {
    
    func createCourse(_ courseEntity: CourseEntity, _ completionHandler: @escaping (MDEntityResult<CourseEntity>)) {
        let operation: MDCreateCourseMemoryStorageOperation = .init(memoryStorage: self,
                                                                    courseEntity: courseEntity) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readCourse(fromCourseId courseId: Int64, _ completionHandler: @escaping (MDEntityResult<CourseEntity>)) {
        let operation: MDReadCourseMemoryStorageOperation = .init(memoryStorage: self,
                                                                  courseId: courseId) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func readAllCourses(_ completionHandler: @escaping (MDEntityResult<[CourseEntity]>)) {
        let operation: MDReadAllCoursesMemoryStorageOperation = .init(memoryStorage: self) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func deleteCourse(fromCourseId courseId: Int64, _ completionHandler: @escaping (MDEntityResult<Void>)) {
        let operation: MDDeleteCourseMemoryStorageOperation = .init(memoryStorage: self,
                                                                    courseId: courseId) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
    func deleteAllCourses(_ completionHandler: @escaping (MDEntityResult<Void>)) {
        let operation: MDDeleteAllCoursesMemoryStorageOperation = .init(memoryStorage: self) { result in
            completionHandler(result)
        }
        operationQueueService.enqueue(operation)
    }
    
}
