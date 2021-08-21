//
//  MDAppDependencies.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 07.07.2021.
//

import UIKit
import Firebase
import Reachability

protocol MDAppDependenciesProtocol {
    var rootWindow: UIWindow! { get }
    var reachability: Reachability! { get }
    var operationQueue: OperationQueue! { get }
    var operationQueueService: OperationQueueServiceProtocol! { get }
    var memoryStorage: MDWordMemoryStorageProtocol! { get }
    var coreDataStorage: MDWordCoreDataStorageProtocol! { get }
    var coreDataStack: CoreDataStack! { get }
    var wordStorage: MDWordStorageProtocol! { get }
}

final class MDAppDependencies: NSObject, MDAppDependenciesProtocol {
    
    var rootWindow: UIWindow!
    var reachability: Reachability!
    var operationQueue: OperationQueue!
    var operationQueueService: OperationQueueServiceProtocol!
    var memoryStorage: MDWordMemoryStorageProtocol!
    var coreDataStorage: MDWordCoreDataStorageProtocol!
    var coreDataStack: CoreDataStack!
    var wordStorage: MDWordStorageProtocol!
    
    init(rootWindow: UIWindow!) {
        self.rootWindow = rootWindow
        super.init()
        configureDependencies()
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDAppDependencies {
    
    func configureDependencies() {
        
        guard let reachability = try? Reachability.init() else { fatalError("Impossible initialize Reachability Service") }
        self.reachability = reachability
        
        let operationQueue: OperationQueue = .init()
        self.operationQueue = operationQueue
        
        let operationQueueService: OperationQueueServiceProtocol = OperationQueueService.init(operationQueue: operationQueue)
        self.operationQueueService = operationQueueService
        
        let memoryStorage: MDWordMemoryStorageProtocol = MDWordMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                  arrayWords: [])
        
        let coreDataStack: CoreDataStack = CoreDataStack.init()
        let coreDataStorage: MDWordCoreDataStorageProtocol = MDWordCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                                        managedObjectContext: coreDataStack.privateContext,
                                                                                        coreDataStack: coreDataStack)
        self.coreDataStorage = coreDataStorage
        
        let wordStorage: MDWordStorageProtocol = MDWordStorage.init(memoryStorage: memoryStorage,
                                                                    coreDataStorage: coreDataStorage)
        self.wordStorage = wordStorage
        
        // Configure FirebaseApp
        FirebaseApp.configure()
        
    }
    
}
