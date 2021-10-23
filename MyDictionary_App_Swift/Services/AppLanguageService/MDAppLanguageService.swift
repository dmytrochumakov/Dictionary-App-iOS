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
    
    fileprivate let defaultAppLanguage: AppLanguageType
    fileprivate let locale: Locale
    fileprivate var languageCode: String?
    
    var appLanguage: AppLanguageType {
        
        //
        guard let lanCode = self.languageCode else { return defaultAppLanguage }
        //
        
        //
        guard let lang = AppLanguageType.init(rawValue: lanCode) else { return defaultAppLanguage }
        //
        
        //
        return lang
        //
        
    }
    
    init(locale: Locale,
         defaultAppLanguage: AppLanguageType) {
        
        self.locale = locale
        self.defaultAppLanguage = defaultAppLanguage
        self.languageCode = locale.languageCode
        
    }
    
}
