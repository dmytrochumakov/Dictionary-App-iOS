//
//  AddCourseDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 23.09.2021.

import Foundation

protocol AddCourseDataProviderProtocol: NumberOfSectionsProtocol,
                                        NumberOfRowsInSectionProtocol {
    
    var filteredLanguages: [LanguageResponse] { get set }
    func addCourseCellModel(atIndexPath indexPath: IndexPath) -> MDAddCourseCellModel?
    
}

final class AddCourseDataProvider: AddCourseDataProviderProtocol {
    
    var filteredLanguages: [LanguageResponse]
    
    init(filteredLanguages: [LanguageResponse]) {
        self.filteredLanguages = filteredLanguages
    }
    
}

extension AddCourseDataProvider {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return filteredLanguages.count
    }
    
}

extension AddCourseDataProvider {
    
    func addCourseCellModel(atIndexPath indexPath: IndexPath) -> MDAddCourseCellModel? {
        if (filteredLanguages.isEmpty) {
            return nil
        } else {
            return .init(title: filteredLanguages[indexPath.row].languageName)
        }
    }
    
}
