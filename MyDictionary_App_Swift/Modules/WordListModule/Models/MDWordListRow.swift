//
//  MDWordListRow.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 26.09.2021.
//

import Foundation

struct MDWordListRow {
    let wordResponse: WordResponse
    var isSelected: Bool
}

// MARK: - Equatable
extension MDWordListRow: Equatable {
    
    static func == (lhs: MDWordListRow, rhs: MDWordListRow) -> Bool {
        return lhs.wordResponse == rhs.wordResponse
    }
    
}
