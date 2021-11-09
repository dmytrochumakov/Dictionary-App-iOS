//
//  MDCreateWordProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

protocol MDCreateWordProtocol {
    
    func createWord(courseUUID: UUID,
                    uuid: UUID,
                    wordText: String,
                    wordDescription: String,
                    createdAt: Date,
                    updatedAt: Date,
                    _ completionHandler: @escaping(MDOperationResultWithCompletion<CDWordEntity>))
    
}
