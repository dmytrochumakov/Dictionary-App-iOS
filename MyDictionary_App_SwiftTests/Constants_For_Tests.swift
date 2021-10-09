//
//  Constants_For_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 17.07.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

struct Constants_For_Tests {
    
    public static let testExpectationTimeout: TimeInterval = 20.0
    
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
    
    public static let mockedUser: UserResponse = .init(userId: 0,
                                                       nickname: "Test nickname",
                                                       createdAt: "2021-08-15T10:34:33.998Z")
    
    public static let mockedUserPassword: String = "mockedUserPassword"
    
    public static let mockedJWT: JWTResponse = .init(accessToken: "asdas;dka;sld;akdkasd;laskld;al",
                                                     expirationDate: "2021-08-15T11:34:33.998Z")
    
    public static let mockedJWTForUpdate: JWTResponse = .init(accessToken: "updated asdas;dka;sld;akdkasd;laskld;al",
                                                              expirationDate: "2021-08-15T13:34:33.998Z")
    
    public static let mockedLanguages: [LanguageResponse] = [.init(languageId: 0,
                                                                   languageName: "English"),
                                                             .init(languageId: 1,
                                                                   languageName: "Spanish")
    ]
    
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
    
    public static var jwtApiRequest: JWTApiRequest {
        
        switch MDConstants.APIEnvironment.current {
        case .development:
            return .init(nickname: authRequest.nickname,
                         password: authRequest.password,
                         userId: 6)
        case .production:
            return .init(nickname: authRequest.nickname,
                         password: authRequest.password,
                         userId: 1)
        }
        
    }
    
    public static var authRequest: AuthRequest {
        return .init(nickname: "test", password: "test")
    }
    
    public static func syncItem(accessToken: String) -> MDSync.Item {
        return .init(accessToken: accessToken,
                     password: authRequest.password,
                     userId:   jwtApiRequest.userId,
                     nickname: authRequest.nickname)
    }
    
    static var operationQueueManager: MDOperationQueueManagerProtocol {
        
        let operationQueues: [OperationQueue] = [MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.jwtMemoryStorageOperationQueue),
                                                 MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.jwtCoreDataStorageOperationQueue),
                                                 MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.jwtAPIOperationQueue),
                                                                                                  
                                                 MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.userMemoryStorageOperationQueue),
                                                 MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.userCoreDataStorageOperationQueue),
                                                 MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.userAPIOperationQueue),
                                                                                                  
                                                 MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.languageMemoryStorageOperationQueue),
                                                 MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.languageCoreDataStorageOperationQueue),
                                                 MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.languageAPIOperationQueue),
                                                                                                  
                                                 MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.courseMemoryStorageOperationQueue),
                                                 MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.courseCoreDataStorageOperationQueue),
                                                 MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.courseAPIOperationQueue),
                                                                                                  
                                                 MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.wordMemoryStorageOperationQueue),
                                                 MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.wordCoreDataStorageOperationQueue),
                                                 MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.wordAPIOperationQueue),
                                                 
                                                 MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.authAPIOperationQueue),
                                                 
                                                 MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.accountAPIOperationQueue),
                                                                                                  
                                                 MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.storageCleanupServiceOperationQueue),
                                                                                                  
                                                 MDConstants.MDOperationQueue.createOperationQueue(byName: MDConstants.QueueName.fillMemoryServiceOperationQueue)
                                                 
        ]
        
        return MDOperationQueueManager.init(operationQueues: operationQueues)
        
    }
    
}
