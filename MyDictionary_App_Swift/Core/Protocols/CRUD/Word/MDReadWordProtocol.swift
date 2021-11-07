//
//  MDReadWordProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

protocol MDReadWordProtocol {
    
    func readWord(fromWordID wordId: Int64,
                  _ completionHandler: @escaping(MDOperationResultWithCompletion<MDWordModel>))
    
    func readWords(fetchLimit: Int,
                   fetchOffset: Int,
                   _ completionHandler: @escaping(MDOperationsResultWithCompletion<MDWordModel>))
    
    func readAllWords(_ completionHandler: @escaping(MDOperationsResultWithCompletion<MDWordModel>))
    
    func readAllWords(byCourseID courseID: Int64,
                      _ completionHandler: @escaping(MDOperationsResultWithCompletion<MDWordModel>))
    
}
