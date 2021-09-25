//
//  MDAddCourseSection.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 24.09.2021.
//

import Foundation

struct MDAddCourseSection {
    let character: String
    var rows: [MDAddCourseRow]
}

// MARK: - Equatable
extension MDAddCourseSection: Equatable {
    
    static func == (lhs: MDAddCourseSection, rhs: MDAddCourseSection) -> Bool {
        return lhs.character == rhs.character
    }
    
}
