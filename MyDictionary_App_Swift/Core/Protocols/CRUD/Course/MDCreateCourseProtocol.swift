//
//  MDCreateCourseProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

protocol MDCreateCourseProtocol {
    func createCourse(_ courseEntity: CDCourseEntity, _ completionHandler: @escaping(MDOperationResultWithCompletion<CDCourseEntity>))
    func createCourses(_ courseEntities: [CDCourseEntity], _ completionHandler: @escaping(MDOperationsResultWithCompletion<CDCourseEntity>))
}
