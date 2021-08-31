//
//  MDDeleteCourseMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 24.08.2021.
//

import Foundation

final class MDDeleteCourseMemoryStorageOperation: MDOperation {
    
    fileprivate let memoryStorage: MDCourseMemoryStorage
    fileprivate let courseId: Int64
    fileprivate let result: MDOperationResultWithCompletion<Void>?
    
    init(memoryStorage: MDCourseMemoryStorage,
         courseId: Int64,
         result: MDOperationResultWithCompletion<Void>?) {
        
        self.memoryStorage = memoryStorage
        self.courseId = courseId
        self.result = result
        
        super.init()
        
    }
    
    override func main() {
        guard let index = self.memoryStorage.array.firstIndex(where: { $0.courseId == self.courseId })
        else {
            self.result?(.failure(MDEntityOperationError.cantFindEntity));
            self.finish();
            return
        }
        self.memoryStorage.array.remove(at: index)
        self.result?(.success(()))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
