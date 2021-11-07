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
    
    public static let mockedCourseName: String = "English"
    public static let mockedCourseTranslatedName: String = "English"       
    
    public static let mockedWordText: String = "MOSF"
    public static let mockedWordDescription: String = "metal–oxide–semiconductor-field"
    
    public static let mockedWordForUpdateWordText: String = "MOSFC"
    public static let mockedWordForUpdateWordDescription: String = "metal–oxide–semiconductor-field-c"        
    
    static var operationQueueManager: MDOperationQueueManagerProtocol {
        
        let operationQueues: [OperationQueue] = [MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.courseCoreDataStorageOperationQueue),
                                                 
                                                 
                                                 MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.wordCoreDataStorageOperationQueue)
                                                 
        ]
        
        return MDOperationQueueManager.init(operationQueues: operationQueues)
        
    }
    
}
