//
//  CDUserResponseEntity+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 17.07.2021.
//

import Foundation

extension CDUserResponseEntity {
    
    var userResponse: UserResponse {
        guard let nickname = self.nickname,
              let password = self.password,
              let createdAt = self.createdAt
        else {
            fatalError()
        }
        return .init(userId: self.userId,
                     nickname: nickname,
                     password: password,
                     createdAt: createdAt)
    }
    
}
