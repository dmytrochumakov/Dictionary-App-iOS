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
    
}
