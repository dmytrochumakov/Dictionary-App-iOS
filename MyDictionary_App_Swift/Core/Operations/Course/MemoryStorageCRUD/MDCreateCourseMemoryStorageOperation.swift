//
//  MDCreateCourseMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

final class MDCreateCourseMemoryStorageOperation: MDOperation {
    
    fileprivate let memoryStorage: MDCourseMemoryStorage
    fileprivate let courseEntity: CourseEntity
    fileprivate let result: MDEntityResult<CourseEntity>?
    
    init(memoryStorage: MDCourseMemoryStorage,
         courseEntity: CourseEntity,
         result: MDEntityResult<CourseEntity>?) {
        
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
