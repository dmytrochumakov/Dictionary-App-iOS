//
//  AppLanguageService.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import Foundation

protocol AppLanguageService {
    var appLanguage: AppLanguageType { get }
}

struct MYAppLanguageService: AppLanguageService {
    
    fileprivate static let appleLanguagesKey: String = "AppleLanguages"
    /// Default is .en
    fileprivate let defaultAppLanguage: AppLanguageType
    /// Default is .current
    fileprivate let locale: Locale
    /// Default is Local.current.languageCode
    fileprivate var languageCode: String?
    
    var appLanguage: AppLanguageType {
        
        guard let lanCode = self.languageCode else { return defaultAppLanguage }
        let stringFromAppleKey = getLanguageStringFromAppleLanguagesKey()
        
        if (stringFromAppleKey == nil) {
            return defaultAppLanguage
        } else {
            let appLanguage = AppLanguageType.allCases.first(where: { $0.rawValue == stringFromAppleKey! })
            if (appLanguage == nil) {
                guard let lang = AppLanguageType.init(rawValue: lanCode) else { return defaultAppLanguage }
                return lang
            } else {
                return appLanguage!
            }
        }
        
    }
    
    static let shared: AppLanguageService = MYAppLanguageService.init(locale: .current)
    
    fileprivate init(locale: Locale) {
        self.locale = locale
        self.defaultAppLanguage = .en
        self.languageCode = locale.languageCode
    }
    
}

// MARK: - Get Language String From Apple Languages Key
fileprivate extension MYAppLanguageService {
    
    func getLanguageStringFromAppleLanguagesKey() -> String? {
        return (UserDefaults.standard.object(forKey: Self.appleLanguagesKey) as? [String])?.first
    }
    
}
