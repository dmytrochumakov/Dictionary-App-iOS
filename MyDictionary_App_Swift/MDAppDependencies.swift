//
//  MDAppDependencies.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 07.07.2021.
//

import Foundation

protocol MDAppDependenciesProtocol {
    
}

final class MDAppDependencies: MDAppDependenciesProtocol {

    var operationQueue: OperationQueue!
    var operationQueueService: OperationQueueServiceProtocol!
    var memoryStorage: MDWordMemoryStorageProtocol!
    var wordStorage: MDWordStorageProtocol!
    
    init() {
        configureDependencies()
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDAppDependencies {
    
    func configureDependencies() {
        
        let operationQueue: OperationQueue = .init()
        self.operationQueue = operationQueue
        
        let operationQueueService: OperationQueueServiceProtocol = OperationQueueService.init(operationQueue: operationQueue)
        self.operationQueueService = operationQueueService
        
        let memoryStorage: MDWordMemoryStorageProtocol = MDWordMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                  arrayWords: [])
        self.memoryStorage = memoryStorage
        
        let wordStorage: MDWordStorageProtocol = MDWordStorage.init(memoryStorage: memoryStorage)
        self.wordStorage = wordStorage
        
    }
    
}
