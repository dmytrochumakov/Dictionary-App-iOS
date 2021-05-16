//
//  KeysForTranslate.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import Foundation

enum KeysForTranslate: String {
    case edit
    case cancel
    case done
    case error
}

// MARK: - LocalizableProtocol
extension KeysForTranslate: LocalizableProtocol {
    
    /// Default is Constants.StaticText.defaultTableName
    var tableName: String {
        return Constants.StaticText.defaultTableName
    }
    
}
