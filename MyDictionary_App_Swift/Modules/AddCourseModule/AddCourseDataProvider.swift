//
//  AddCourseDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 23.09.2021.

import Foundation

protocol AddCourseDataProviderProtocol: NumberOfSectionsProtocol,
                                        NumberOfRowsInSectionProtocol {
    
    var languages: [LanguageResponse] { get set }
    func addCourseCellModel(atIndexPath indexPath: IndexPath) -> MDAddCourseCellModel?
    
}

final class AddCourseDataProvider: AddCourseDataProviderProtocol {
    
    var languages: [LanguageResponse]
    
    init(languages: [LanguageResponse]) {
        self.languages = languages
    }
    
}

extension AddCourseDataProvider {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return languages.count
    }
    
}

extension AddCourseDataProvider {
    
    func addCourseCellModel(atIndexPath indexPath: IndexPath) -> MDAddCourseCellModel? {
        if (languages.isEmpty) {
            return nil
        } else {
            return .init(title: languages[indexPath.row].languageName)
        }
    }
    
}
