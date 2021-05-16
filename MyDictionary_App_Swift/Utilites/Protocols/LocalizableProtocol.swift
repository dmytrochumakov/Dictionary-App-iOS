//
//  LocalizableProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import Foundation

protocol LocalizableProtocol {
    var tableName: String { get }
    var localized: String { get }
}

extension LocalizableProtocol where Self: RawRepresentable, Self.RawValue == String {
            
    func localized(lang: AppLanguageType, tableName: String) -> String {
        return rawValue.localized(lang: lang.rawValue, tableName: tableName)
    }
    
    /// - Parameter lang: MYAppLanguageService.shared.appLanguage.rawValue
    /// - Parameter tableName: Constants.StaticText.defaultTableName
    var localized: String {
        return rawValue.localized(lang: MYAppLanguageService.shared.appLanguage.rawValue,
                                  tableName: Constants.StaticText.defaultTableName)
    }
    
}
