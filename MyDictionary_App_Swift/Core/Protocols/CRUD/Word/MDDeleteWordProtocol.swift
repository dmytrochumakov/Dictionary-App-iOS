//
//  MDDeleteWordProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

protocol MDDeleteWordProtocol {
    
    func deleteWord(byWordUUID uuid: UUID,
                    _ completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
    
    func deleteAllWords(byCourseUUID uuid: UUID,
                        _ completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
    
    func deleteAllWords(_ completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
    
}
