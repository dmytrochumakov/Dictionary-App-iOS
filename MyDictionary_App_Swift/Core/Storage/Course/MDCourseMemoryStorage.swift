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
    
    fileprivate let operationQueue: OperationQueue
    
    var array: [CourseResponse]
    
    init(operationQueue: OperationQueue,
         array: [CourseResponse]) {
        
        self.operationQueue = operationQueue
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

// MARK: - Create
extension MDCourseMemoryStorage {
    
    func createCourse(_ courseEntity: CourseResponse,
                      _ completionHandler: @escaping (MDOperationResultWithCompletion<CourseResponse>)) {
        
        let operation: BlockOperation = .init {
            
            //
            self.array.append(courseEntity)
            //
            
            //
            completionHandler(.success(courseEntity))
            //
            
            //
            return
            //
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
    func createCourses(_ courseEntities: [CourseResponse],
                       _ completionHandler: @escaping (MDOperationsResultWithCompletion<CourseResponse>)) {
        
        let operation: BlockOperation = .init {
            
            if (courseEntities.isEmpty) {
                
                //
                completionHandler(.success(courseEntities))
                //
                
                //
                return
                //
                
            } else {
                
                courseEntities.forEach { courseEntity in
                    self.array.append(courseEntity)
                }
                
                //
                completionHandler(.success(self.array))
                //
                
                //
                return
                //
                
            }
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
}

// MARK: - Read
extension MDCourseMemoryStorage {
    
    func readCourse(fromCourseId courseId: Int64,
                    _ completionHandler: @escaping (MDOperationResultWithCompletion<CourseResponse>)) {
        
        let operation: BlockOperation = .init {
            
            guard let course = self.array.first(where: { $0.courseId == courseId })
            else {
                
                //
                completionHandler(.failure(MDEntityOperationError.cantFindEntity))
                //
                
                //
                return
                //
                
            }
            
            //
            completionHandler(.success(course))
            //
            
            //
            return
            //
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
    func readAllCourses(_ completionHandler: @escaping (MDOperationResultWithCompletion<[CourseResponse]>)) {
        
        let operation: BlockOperation = .init {
            
            //
            completionHandler(.success(self.array))
            //
            
            //
            return
            //
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
}

// MARK: - Delete
extension MDCourseMemoryStorage {
    
    func deleteCourse(fromCourseId courseId: Int64,
                      _ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            guard let index = self.array.firstIndex(where: { $0.courseId == courseId })
            else {
                
                //
                completionHandler(.failure(MDEntityOperationError.cantFindEntity));
                //
                
                //
                return
                //
                
            }
            
            //
            self.array.remove(at: index)
            //
            
            //
            completionHandler(.success(()))
            //
            
            //
            return
            //
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
    func deleteAllCourses(_ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            //
            self.array.removeAll()
            //
            
            //
            completionHandler(.success(()))
            //
            
            //
            return
            //
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
}
