//
//  MDReadCourseProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

protocol MDReadCourseByCourseUUIDProtocol {
    
    func readCourse(byCourseUUID uuid: UUID,
                    _ completionHandler: @escaping(MDOperationResultWithCompletion<CDCourseEntity>))
    
}

protocol MDReadCoursesWithFetchLimitAndFetchOffsetProtocol {
    
    func readCourses(fetchLimit: Int,
                     fetchOffset: Int,
                     ascending: Bool,
                     _ completionHandler: @escaping(MDOperationsResultWithCompletion<CDCourseEntity>))
    
}

protocol MDReadAllCoursesProtocol {
    
    func readAllCourses(ascending: Bool,
                        _ completionHandler: @escaping(MDOperationsResultWithCompletion<CDCourseEntity>))
    
}

protocol MDReadCourseProtocol: MDReadCourseByCourseUUIDProtocol,
                               MDReadCoursesWithFetchLimitAndFetchOffsetProtocol,
                               MDReadAllCoursesProtocol {
    
    
    
}
