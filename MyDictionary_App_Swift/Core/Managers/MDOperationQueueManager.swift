//
//  MDOperationQueueManager.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 04.10.2021.
//

import Foundation

protocol MDOperationQueueManagerProtocol {
    func appendOperationQueue(_ oq: OperationQueue)
    func operationQueue(byName name: String) -> OperationQueue?
    func cancelAllOperations()
    func removeAllOperationQueues()
}

final class MDOperationQueueManager: MDOperationQueueManagerProtocol {
    
    fileprivate var operationQueues: [OperationQueue]
    
    init(operationQueues: [OperationQueue]) {
        self.operationQueues = operationQueues
    }
    
    deinit {
        //
        removeAllOperationQueues()
        //
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - MDOperationQueueStorageManagerProtocol
extension MDOperationQueueManager {
    
    func appendOperationQueue(_ oq: OperationQueue) {
        operationQueues.append(oq)
    }
    
    func operationQueue(byName name: String) -> OperationQueue? {
        return operationQueues.first(where:  { $0.name == name })
    }
    
    func cancelAllOperations() {
        //
        operationQueues.forEach { operationQueue in
            //
            operationQueue.cancelAllOperations()
            //
        }
        //
    }
    
    func removeAllOperationQueues() {
        //
        cancelAllOperations()
        //
        operationQueues.removeAll()
        //
    }
    
}
