//
//  CDJWTResponseEntity+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 14.08.2021.
//

import Foundation

extension CDJWTResponseEntity {
    
    var jwtResponse: JWTResponse {
        guard let accessToken = self.accessToken,
              let expirationDate = self.expirationDate
        else {
            fatalError()
        }
        return .init(accessToken: accessToken,
                     expirationDate: expirationDate)
    }
    
}
