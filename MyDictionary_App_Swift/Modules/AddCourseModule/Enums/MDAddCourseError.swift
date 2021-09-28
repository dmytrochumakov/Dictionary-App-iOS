//
//  MDAddCourseError.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 25.09.2021.
//

import Foundation

enum MDAddCourseError: Error {
    case pleaseSelectACourse
}

extension MDAddCourseError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .pleaseSelectACourse:
            return MDLocalizedText.pleaseSelectACourse.localized
        }
    }
    
}
