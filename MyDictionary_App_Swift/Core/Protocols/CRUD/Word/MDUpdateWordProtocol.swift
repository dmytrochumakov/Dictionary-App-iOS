//
//  MDUpdateWordProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

protocol MDUpdateWordProtocol {
    
    func updateWord(byCourseUUID courseUUID: UUID,
                    andWordUUID wordUUID: UUID,
                    newWordText: String,
                    newWordDescription: String,
                    newUpdatedAt: Date,
                    _ completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
    
    func updateWord(byCourseUUID courseUUID: UUID,
                    andWordUUID wordUUID: UUID,
                    newWordDescription: String,
                    newUpdatedAt: Date,
                    _ completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
    
}
