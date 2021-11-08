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
                                             languageId: 1,                                             
                                             createdAt: .init())
    }
    
    public static func mockedWord(context: NSManagedObjectContext) -> CDWordEntity {
        return CDWordEntity.cdWordEntity(context: context,
                                         courseUUID: .init(),
                                         uuid: .init(),
                                         wordText: "MOSF",
                                         wordDescription: "metal–oxide–semiconductor-field",
                                         createdAt: .init(),
                                         updatedAt: .init())
    }
    
    public static func mockedWordForUpdate(context: NSManagedObjectContext) -> CDWordEntity {
        return CDWordEntity.cdWordEntity(context: context,
                                         courseUUID: .init(),
                                         uuid: .init(),
                                         wordText: "MOSFC",
                                         wordDescription: "metal–oxide–semiconductor-field-c",
                                         createdAt: .init(),
                                         updatedAt: .init())
    }
    
    static var operationQueueManager: MDOperationQueueManagerProtocol {
        
        let operationQueues: [OperationQueue] = [MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.courseCoreDataStorageOperationQueue),
                                                 
                                                 
                                                 MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.wordCoreDataStorageOperationQueue)
                                                 
        ]
        
        return MDOperationQueueManager.init(operationQueues: operationQueues)
        
    }
    
}
