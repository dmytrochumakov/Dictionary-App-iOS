//
//  MDDeleteAllWordsMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

final class MDDeleteAllWordsMemoryStorageOperation: MDOperation {
    
    fileprivate let wordStorage: MDWordMemoryStorage
    fileprivate let result: MDOperationResultWithCompletion<Void>?
    
    init(wordStorage: MDWordMemoryStorage,
         result: MDOperationResultWithCompletion<Void>?) {
        
        self.wordStorage = wordStorage
        self.result = result
        
        super.init()
    }
    
    override func main() {
        self.wordStorage.arrayWords.removeAll()
        self.result?(.success(()))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}

final class MDDeleteAllWordsByCourseIdMemoryStorageOperation: MDOperation {
    
    fileprivate let wordStorage: MDWordMemoryStorage
    fileprivate let courseId: Int64
    fileprivate let result: MDOperationResultWithCompletion<Void>?
    
    init(wordStorage: MDWordMemoryStorage,
         courseId: Int64,
         result: MDOperationResultWithCompletion<Void>?) {
        
        self.wordStorage = wordStorage
        self.courseId = courseId
        self.result = result
        
        super.init()
    }
    
    override func main() {
        self.wordStorage.arrayWords.removeAll(where: { $0.courseId == self.courseId })
        self.result?(.success(()))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
