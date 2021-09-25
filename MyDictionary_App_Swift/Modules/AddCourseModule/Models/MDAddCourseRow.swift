//
//  MDAddCourseRow.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 24.09.2021.
//

import Foundation

struct MDAddCourseRow {
    let languageResponse: LanguageResponse
    var isSelected: Bool
}

// MARK: - Equatable
extension MDAddCourseRow: Equatable {
    
    static func == (lhs: MDAddCourseRow, rhs: MDAddCourseRow) -> Bool {
        return lhs.languageResponse == rhs.languageResponse
    }
    
}
