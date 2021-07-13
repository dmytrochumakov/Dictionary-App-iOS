//
//  MDAPIEnvironment.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.07.2021.
//

import Foundation

enum MDAPIEnvironment: MDEnvironmentProtocol {
    
    case development
    case openLibrary
    
    var baseURL: String {
        switch self {
        case .development:
            return "http://localhost:8000/api/"
        case .openLibrary:
            return "https://openlibrary.org/"
        }
    }
    
}
