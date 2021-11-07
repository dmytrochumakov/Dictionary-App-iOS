//
//  MDReadWordProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

protocol MDReadWordProtocol {
    
    func readWord(fromWordID wordId: Int64,
                  _ completionHandler: @escaping(MDOperationResultWithCompletion<CDWordEntity>))
    
    func readWords(fetchLimit: Int,
                   fetchOffset: Int,
                   _ completionHandler: @escaping(MDOperationsResultWithCompletion<CDWordEntity>))
    
    func readAllWords(_ completionHandler: @escaping(MDOperationsResultWithCompletion<CDWordEntity>))
    
    func readAllWords(byCourseID courseID: Int64,
                      _ completionHandler: @escaping(MDOperationsResultWithCompletion<CDWordEntity>))
    
}
