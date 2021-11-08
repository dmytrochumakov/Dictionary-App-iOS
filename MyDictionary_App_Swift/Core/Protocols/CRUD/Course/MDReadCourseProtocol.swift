//
//  MDReadCourseProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

protocol MDReadCourseProtocol {
    
    func readCourse(byCourseUUID uuid: UUID,
                    _ completionHandler: @escaping(MDOperationResultWithCompletion<CDCourseEntity>))
    
    func readCourses(fetchLimit: Int,
                     fetchOffset: Int,
                     _ completionHandler: @escaping(MDOperationsResultWithCompletion<CDCourseEntity>))
    
    func readAllCourses(_ completionHandler: @escaping(MDOperationsResultWithCompletion<CDCourseEntity>))
    
}
