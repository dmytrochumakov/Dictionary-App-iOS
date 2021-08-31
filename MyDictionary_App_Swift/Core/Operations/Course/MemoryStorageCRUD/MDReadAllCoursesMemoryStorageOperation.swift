//
//  MDReadAllCoursesMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 24.08.2021.
//

import Foundation

final class MDReadAllCoursesMemoryStorageOperation: MDOperation {
    
    fileprivate let memoryStorage: MDCourseMemoryStorage
    fileprivate let result: MDOperationsResultWithCompletion<CourseResponse>?
    
    init(memoryStorage: MDCourseMemoryStorage,
         result: MDOperationsResultWithCompletion<CourseResponse>?) {
        
        self.memoryStorage = memoryStorage
        self.result = result
        
        super.init()
    }
    
    override func main() {
        self.result?(.success(self.memoryStorage.array))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
