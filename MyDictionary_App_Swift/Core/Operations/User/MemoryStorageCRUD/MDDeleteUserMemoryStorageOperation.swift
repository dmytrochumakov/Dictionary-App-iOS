//
//  MDDeleteUserMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

final class MDDeleteUserMemoryStorageOperation: MDOperation {
    
    fileprivate let memoryStorage: MDUserMemoryStorage
    fileprivate let userId: Int64
    fileprivate let result: MDOperationResultWithCompletion<Void>?
    
    init(memoryStorage: MDUserMemoryStorage,
         userId: Int64,
         result: MDOperationResultWithCompletion<Void>?) {
        
        self.memoryStorage = memoryStorage
        self.userId = userId
        self.result = result
        
        super.init()
        
    }
    
    override func main() {
        guard let index = self.memoryStorage.array.firstIndex(where: { $0.userId == self.userId })
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
