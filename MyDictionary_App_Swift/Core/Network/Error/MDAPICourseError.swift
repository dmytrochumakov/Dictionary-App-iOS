//
//  MDAPICourseError.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 25.09.2021.
//

import Foundation

enum MDAPICourseError: Error {
    case conflict
}

extension MDAPICourseError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .conflict:
            return MDLocalizedText.conflictApiCourseError.localized
        }
    }
    
}
