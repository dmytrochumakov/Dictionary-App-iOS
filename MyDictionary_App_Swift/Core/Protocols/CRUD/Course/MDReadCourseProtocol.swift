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
                     ascending: Bool,
                     _ completionHandler: @escaping(MDOperationsResultWithCompletion<CDCourseEntity>))
    
    func readAllCourses(ascending: Bool, _ completionHandler: @escaping(MDOperationsResultWithCompletion<CDCourseEntity>))
    
}
