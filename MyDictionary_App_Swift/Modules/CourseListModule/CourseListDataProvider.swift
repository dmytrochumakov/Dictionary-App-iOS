//
//  CourseListDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 11.08.2021.

import Foundation

protocol CourseListDataProviderProtocol: NumberOfSectionsProtocol,
                                         NumberOfRowsInSectionProtocol {
    
}

final class CourseListDataProvider: CourseListDataProviderProtocol {
    
}

extension CourseListDataProvider {
    
    var numberOfSections: Int {
        return 0
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return 0
    }
    
}
