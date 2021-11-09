//
//  MDCourseListModel.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 09.11.2021.
//

import Foundation

struct MDCourseListModel {
    let course: CDCourseEntity
    let language: MDLanguageModel
}

// MARK: - MDTextForSearchWithOnePropertyProtocol
extension MDCourseListModel: MDTextForSearchWithOnePropertyProtocol {
    
    var textForSearch: String {
        return language.name
    }
    
}
