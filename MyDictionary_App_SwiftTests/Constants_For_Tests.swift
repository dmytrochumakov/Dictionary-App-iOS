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
    
    public static let mockedWord0: WordModel = .init(user_id: .init(),
                                                     id: .init(),
                                                     word: "MOSF",
                                                     word_description: "metal–oxide–semiconductor-field",
                                                     word_language: "English",
                                                     created_at: .init(),
                                                     updated_at: .init())
    
    public static let mockedWordForUpdate: WordModel = .init(user_id: .init(),
                                                             id: .init(),
                                                             word: "MOSFC",
                                                             word_description: "metal–oxide–semiconductor-field-c",
                                                             word_language: "Spanish",
                                                             created_at: .init(),
                                                             updated_at: .init())
    
    public static let mockedUser: UserEntity = .init(userId: 0,
                                                     nickname: "Test nickname",
                                                     password: "test password",
                                                     createdAt: "2021-08-15T10:34:33.998Z",
                                                     updatedAt: "2021-08-15T10:34:33.998Z")
    
    public static let mockedJWT: AuthResponse = .init(accessToken: "asdas;dka;sld;akdkasd;laskld;al",
                                                      expirationDate: "2021-08-15T11:34:33.998Z")
    
    public static let mockedJWTForUpdate: AuthResponse = .init(accessToken: "updated asdas;dka;sld;akdkasd;laskld;al",
                                                               expirationDate: "2021-08-15T13:34:33.998Z")
    
}
