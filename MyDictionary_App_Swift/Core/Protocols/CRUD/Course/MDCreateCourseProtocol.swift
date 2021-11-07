//
//  MDCreateCourseProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

protocol MDCreateCourseProtocol {
    
    func createCourse(name: String,
                      translatedName: String,
                      _ completionHandler: @escaping(MDOperationResultWithCompletion<CDCourseEntity>))
        
}
