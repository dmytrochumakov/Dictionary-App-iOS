//
//  MDCreateCourseMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

final class MDCreateCourseMemoryStorageOperation: MDOperation {
    
    fileprivate let memoryStorage: MDCourseMemoryStorage
    fileprivate let courseEntity: CourseResponse
    fileprivate let result: MDOperationResultWithCompletion<CourseResponse>?
    
    init(memoryStorage: MDCourseMemoryStorage,
         courseEntity: CourseResponse,
         result: MDOperationResultWithCompletion<CourseResponse>?) {
        
        self.memoryStorage = memoryStorage
        self.courseEntity = courseEntity
        self.result = result
        
        super.init()
    }
    
    override func main() {
        self.memoryStorage.array.append(courseEntity)
        self.result?(.success(self.courseEntity))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}

final class MDCreateCoursesMemoryStorageOperation: MDOperation {
    
    fileprivate let memoryStorage: MDCourseMemoryStorage
    fileprivate let courseEntities: [CourseResponse]
    fileprivate let result: MDOperationsResultWithCompletion<CourseResponse>?
    
    init(memoryStorage: MDCourseMemoryStorage,
         courseEntities: [CourseResponse],
         result: MDOperationsResultWithCompletion<CourseResponse>?) {
        
        self.memoryStorage = memoryStorage
        self.courseEntities = courseEntities
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        self.courseEntities.forEach { courseEntity in
            self.memoryStorage.array.append(courseEntity)
        }
        
        self.result?(.success(self.memoryStorage.array))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
