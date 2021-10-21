//
//  MDAppLanguageService.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import Foundation

protocol MDAppLanguageServiceProtocol {
    var appLanguage: AppLanguageType { get }
}

final class MDAppLanguageService: MDAppLanguageServiceProtocol {
    
    fileprivate static let appleLanguagesKey: String = "AppleLanguages"
    
    fileprivate let defaultAppLanguage: AppLanguageType
    fileprivate let locale: Locale
    fileprivate var languageCode: String?
    
    var appLanguage: AppLanguageType {
        
        //
        guard let lanCode = self.languageCode else { return defaultAppLanguage }
        //
        
        //
        let stringFromAppleKey = getLanguageStringFromAppleLanguagesKey()
        //
        
        if (stringFromAppleKey == nil) {
            
            //
            return defaultAppLanguage
            //
            
        } else {
            
            //
            let appLanguage = AppLanguageType.allCases.first(where: { $0.rawValue == stringFromAppleKey! })
            //
            
            if (appLanguage == nil) {
                
                //
                guard let lang = AppLanguageType.init(rawValue: lanCode) else { return defaultAppLanguage }
                //
                
                //
                return lang
                //
                
            } else {
                return appLanguage!
            }
            
            //
            
        }
        
    }
    
    init(locale: Locale,
         defaultAppLanguage: AppLanguageType) {
        
        self.locale = locale
        self.defaultAppLanguage = defaultAppLanguage
        self.languageCode = locale.languageCode
        
    }
    
}

// MARK: - Get Language String From Apple Languages Key
fileprivate extension MDAppLanguageService {
    
    func getLanguageStringFromAppleLanguagesKey() -> String? {
        return (UserDefaults.standard.object(forKey: Self.appleLanguagesKey) as? [String])?.first
    }
    
}
