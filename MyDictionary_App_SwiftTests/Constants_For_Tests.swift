//
//  Constants_For_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 17.07.2021.
//

import XCTest
import CoreData
@testable import MyDictionary_App_Swift

struct Constants_For_Tests {
    
    public static let testExpectationTimeout: TimeInterval = 60.0
    
    public static func mockedCourse(context: NSManagedObjectContext) -> CDCourseEntity {
        return CDCourseEntity.cdCourseEntity(context: context,
                                             uuid: .init(),
                                             name: "English",
                                             translatedName: "English",
                                             createdAt: .init(),
                                             words: nil)
    }
    
    public static func mockedWord0(context: NSManagedObjectContext) -> CDWordEntity {
        return CDWordEntity.cdWordEntity(context: context,
                                         uuid: .init(),
                                         wordText: "MOSF",
                                         wordDescription: "metal–oxide–semiconductor-field",
                                         createdAt: Date.init(),
                                         updatedAt: Date.init(),
                                         courseUUID: nil)
    }
    
    public static func mockedWordForUpdate(context: NSManagedObjectContext) -> CDWordEntity {
        return CDWordEntity.cdWordEntity(context: context,
                                         uuid: .init(),
                                         wordText: "MOSFC",
                                         wordDescription: "metal–oxide–semiconductor-field-c",
                                         createdAt: Date.init(),
                                         updatedAt: Date.init(),
                                         courseUUID: nil)
    }
    
    static var operationQueueManager: MDOperationQueueManagerProtocol {
        
        let operationQueues: [OperationQueue] = [MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.courseCoreDataStorageOperationQueue),
                                                 
                                                 
                                                 MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.wordCoreDataStorageOperationQueue)
                                                 
        ]
        
        return MDOperationQueueManager.init(operationQueues: operationQueues)
        
    }
    
}
