//
//  MDDeleteAllCoursesMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 24.08.2021.
//

import Foundation

final class MDDeleteAllCoursesMemoryStorageOperation: MDOperation {
    
    fileprivate let memoryStorage: MDCourseMemoryStorage
    fileprivate let result: MDOperationResultWithCompletion<Void>?
    
    init(memoryStorage: MDCourseMemoryStorage,
         result: MDOperationResultWithCompletion<Void>?) {
        
        self.memoryStorage = memoryStorage
        self.result = result
        
        super.init()
        
    }
    
    override func main() {
        self.memoryStorage.array.removeAll()        
        self.result?(.success(()))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
