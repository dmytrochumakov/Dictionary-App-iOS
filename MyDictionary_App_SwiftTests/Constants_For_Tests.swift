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
    
    public static let mockedWord0: WordEntity = .init(userId: .init(),
                                                      wordId: .init(),
                                                      courseId: .init(),
                                                      languageId: .init(),
                                                      wordText: "MOSF",
                                                      wordDescription: "metal–oxide–semiconductor-field",
                                                      languageName: "English",
                                                      createdAt: .init(),
                                                      updatedAt: .init())
    
    public static let mockedWordForUpdate: WordEntity = .init(userId: .init(),
                                                              wordId: .init(),
                                                              courseId: .init(),
                                                              languageId: .init(),
                                                              wordText: "MOSFC",
                                                              wordDescription: "metal–oxide–semiconductor-field-c",
                                                              languageName: "English",
                                                              createdAt: .init(),
                                                              updatedAt: .init())
    
    public static let mockedUser: UserEntity = .init(userId: 0,
                                                     nickname: "Test nickname",
                                                     password: "test password",
                                                     createdAt: "2021-08-15T10:34:33.998Z",
                                                     updatedAt: "2021-08-15T10:34:33.998Z")
    
    public static let mockedJWT: JWTResponse = .init(accessToken: "asdas;dka;sld;akdkasd;laskld;al",
                                                     expirationDate: "2021-08-15T11:34:33.998Z")
    
    public static let mockedJWTForUpdate: JWTResponse = .init(accessToken: "updated asdas;dka;sld;akdkasd;laskld;al",
                                                              expirationDate: "2021-08-15T13:34:33.998Z")
    
    public static let mockedLanguages: [LanguageEntity] = [.init(languageId: 0,
                                                                 languageName: "English",
                                                                 createdAt: "2021-08-15T13:34:33.998Z"),
                                                           .init(languageId: 1,
                                                                 languageName: "Spanish",
                                                                 createdAt: "2021-08-15T13:34:33.999Z")
    ]
    
}
