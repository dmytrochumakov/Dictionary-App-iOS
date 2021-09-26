//
//  MDWordListSection.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 26.09.2021.
//

import Foundation

struct MDWordListSection {
    let character: String
    let rows: [MDWordListRow]
}

// MARK: - Equatable
extension MDWordListSection: Equatable {
        
    static func == (lhs: MDWordListSection, rhs: MDWordListSection) -> Bool {
        return lhs.character == rhs.character
    }
    
}
