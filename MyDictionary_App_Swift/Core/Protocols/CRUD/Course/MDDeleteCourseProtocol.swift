//
//  MDDeleteCourseProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

protocol MDDeleteCourseProtocol {
    
    func deleteCourse(byCourseUUID uuid: UUID,
                      _ completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
    
    func deleteAllCourses(_ completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
    
}
