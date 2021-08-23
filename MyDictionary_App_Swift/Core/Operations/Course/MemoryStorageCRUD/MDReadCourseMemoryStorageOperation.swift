//
//  MDReadCourseMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

final class MDReadCourseMemoryStorageOperation: MDOperation {
    
    fileprivate let memoryStorage: MDCourseMemoryStorage
    fileprivate let courseId: Int64
    fileprivate let result: MDEntityResult<CourseEntity>?
    
    init(memoryStorage: MDCourseMemoryStorage,
         courseId: Int64,
         result: MDEntityResult<CourseEntity>?) {
        
        self.memoryStorage = memoryStorage
        self.courseId = courseId
        self.result = result
        
        super.init()
    }
    
    override func main() {
        guard let course = self.memoryStorage.array.first(where: { $0.courseId == self.courseId })
        else {
            self.result?(.failure(MDEntityOperationError.cantFindEntity));
            self.finish();
            return
        }
        self.result?(.success(course))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
