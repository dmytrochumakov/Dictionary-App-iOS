//
//  MDCreateWordProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

protocol MDCreateWordProtocol {
    
    func createWord(wordText: String,
                    wordDescription: String,
                    course: CDCourseEntity?,
                    _ completionHandler: @escaping(MDOperationResultWithCompletion<CDWordEntity>))
    
}
