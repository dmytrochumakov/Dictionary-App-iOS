//
//  AddCourseDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 23.09.2021.

import Foundation

protocol AddCourseDataProviderProtocol {
    var languages: [LanguageResponse] { get set }
}

final class AddCourseDataProvider: AddCourseDataProviderProtocol {
    
    var languages: [LanguageResponse]
    
    init(languages: [LanguageResponse]) {
        self.languages = languages
    }
    
}
