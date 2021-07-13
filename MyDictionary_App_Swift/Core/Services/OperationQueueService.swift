//
//  OperationQueueService.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

protocol OperationQueueServiceProtocol {
    func enqueue(_ operation: Operation)
    func cancelAllOperations()
    var operationCount: Int { get }
}

final class OperationQueueService: OperationQueueServiceProtocol {
    
    fileprivate let operationQueue: OperationQueue
    
    init(operationQueue: OperationQueue) {
        self.operationQueue = operationQueue
    }
    
    deinit {
        cancelAllOperations()
    }
    
}

extension OperationQueueService {
    
    func enqueue(_ operation: Operation) {
        operationQueue.addOperation(operation)
    }
    
    func cancelAllOperations() {
        operationQueue.cancelAllOperations()
    }
    
    var operationCount: Int {
        return operationQueue.operationCount
    }
    
}
