//
//  CDLanguageResponseEntity+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 22.08.2021.
//

import Foundation

extension CDLanguageResponseEntity {
    
    var languageResponse: LanguageResponse {
        guard let languageName = self.languageName              
        else {
            fatalError()
        }
        return .init(languageId: self.languageId,
                     languageName: languageName)
    }
    
}
