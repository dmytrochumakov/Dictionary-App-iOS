//
//  JWTResponse.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.08.2021.
//

import Foundation
import CoreData

struct JWTResponse {
    
    let accessToken: String
    /// Time Zone - UTC
    /// Date Format - yyyy-MM-dd'T'HH:mm:ss.SSS'Z'
    let expirationDate: String
    
    var expDate: Date? {
        let format: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let dateFormatter: DateFormatter = .init()
        dateFormatter.timeZone = TimeZone.init(identifier: "UTC")!
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: expirationDate)
    }
    
}

extension JWTResponse {
    
    func cdJWTResponseEntity(context: NSManagedObjectContext) -> CDJWTResponseEntity {
        
        let cdJWTResponseEntity: CDJWTResponseEntity = .init(context: context)
        
        cdJWTResponseEntity.accessToken = self.accessToken
        cdJWTResponseEntity.expirationDate = self.expirationDate
        
        return cdJWTResponseEntity
        
    }
    
}

extension JWTResponse: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expirationDate = "expiration_date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.accessToken = try container.decode(String.self, forKey: .accessToken)
        self.expirationDate = try container.decode(String.self, forKey: .expirationDate)
    }
    
}
