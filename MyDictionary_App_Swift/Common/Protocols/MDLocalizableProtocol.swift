//
//  MDLocalizableProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import Foundation

protocol MDLocalizableProtocol {
    var tableName: String { get }
    var localized: String { get }
}

extension MDLocalizableProtocol where Self: RawRepresentable, Self.RawValue == String {
    
    func localized(lang: AppLanguageType, tableName: String) -> String {
        return rawValue.localized(lang: lang.rawValue, tableName: tableName)
    }
    
    /// - Parameter lang: MDConstants.AppDependencies.dependencies.appLanguageService.appLanguage.rawValue
    /// - Parameter tableName: MDConstants.StaticText.defaultTableName
    var localized: String {
        return rawValue.localized(lang: MDConstants.AppDependencies.dependencies.appLanguageService.appLanguage.rawValue,
                                  tableName: MDConstants.StaticText.defaultTableName)
    }
    
}
