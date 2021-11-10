//
//  MDCourseOperationError.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 10.11.2021.
//

import Foundation

enum MDCourseOperationError: Error {
    case courseExists
}

// MARK: - LocalizedError
extension MDCourseOperationError: LocalizedError {
    
    var errorDescription: String? {
        
        switch self {
            
        case .courseExists:
            return MDLocalizedText.conflictApiCourseError.localized
        }
        
    }
    
}
