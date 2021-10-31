//
//  Constants_For_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 17.07.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

struct Constants_For_Tests {
    
    public static let testExpectationTimeout: TimeInterval = 60.0
    
    public static let mockedWord0: WordResponse = .init(userId: .init(),
                                                        wordId: .init(),
                                                        courseId: .init(),
                                                        languageId: .init(),
                                                        wordText: "MOSF",
                                                        wordDescription: "metal–oxide–semiconductor-field",
                                                        languageName: "English",
                                                        createdAt: .init())
    
    public static let mockedWords: [WordResponse] = [mockedWord0, .init(userId: .init(),
                                                                        wordId: .init(),
                                                                        courseId: .init(),
                                                                        languageId: .init(),
                                                                        wordText: "MOSF",
                                                                        wordDescription: "metal–oxide–semiconductor-field",
                                                                        languageName: "Spanish",
                                                                        createdAt: .init())]
    
    public static let mockedWordForUpdate: WordResponse = .init(userId: .init(),
                                                                wordId: .init(),
                                                                courseId: .init(),
                                                                languageId: .init(),
                                                                wordText: "MOSFC",
                                                                wordDescription: "metal–oxide–semiconductor-field-c",
                                                                languageName: "English",
                                                                createdAt: .init())
        
    public static let mockedCourse: CourseResponse = .init(userId: 0,
                                                           courseId: 0,
                                                           languageId: 0,
                                                           languageName: "English",
                                                           createdAt: "2021-08-16T13:35:33.999Z")
    
    public static let mockedCourses: [CourseResponse] = [mockedCourse, .init(userId: 1,
                                                                             courseId: 1,
                                                                             languageId: 1,
                                                                             languageName: "Spanish",
                                                                             createdAt: "2021-08-16T13:36:33.999Z")]
    
    static var operationQueueManager: MDOperationQueueManagerProtocol {
        
        let operationQueues: [OperationQueue] = [MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.courseCoreDataStorageOperationQueue),
                                                 
                                                 
                                                 MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.wordCoreDataStorageOperationQueue)
                                                                                                  
        ]
        
        return MDOperationQueueManager.init(operationQueues: operationQueues)
        
    }
    
}
