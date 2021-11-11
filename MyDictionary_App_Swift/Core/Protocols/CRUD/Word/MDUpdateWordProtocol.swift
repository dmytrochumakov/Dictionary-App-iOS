//
//  MDUpdateWordProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

protocol MDUpdateWordTextAndWordDescriptionProtocol {
    
    func updateWordTextAndWordDescription(byCourseUUID courseUUID: UUID,
                                          andWordUUID wordUUID: UUID,
                                          newWordText: String,
                                          newWordDescription: String,
                                          _ completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
    
}

protocol MDUpdateWordDescriptionProtocol {
    
    func updateWordDescription(byCourseUUID courseUUID: UUID,
                               andWordUUID wordUUID: UUID,
                               newWordDescription: String,
                               _ completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
    
}

protocol MDUpdateWordProtocol: MDUpdateWordTextAndWordDescriptionProtocol,
                               MDUpdateWordDescriptionProtocol {
    
    
}
