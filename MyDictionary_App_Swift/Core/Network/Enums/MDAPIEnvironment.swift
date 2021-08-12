//
//  MDAPIEnvironment.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.07.2021.
//

import Foundation

enum MDAPIEnvironment: MDEnvironmentProtocol {
    
    case development
    case production
    
    var baseURL: String {
        switch self {
        case .development:
            return "http://localhost:8089/api/\(MDAPIVersion.v1.rawValue)/"
        case .production:
            return "https://my-dictionary-rest-api-cloud-run-service-s3h77mhuwa-uc.a.run.app/api/\(MDAPIVersion.v1.rawValue)/"
        }
    }
    
}
