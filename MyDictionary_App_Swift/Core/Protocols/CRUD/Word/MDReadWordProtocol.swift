//
//  MDReadWordProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

protocol MDReadWordByWordUUIDProtocol {
    
    func readWord(byWordUUID uuid: UUID,
                  _ completionHandler: @escaping(MDOperationResultWithCompletion<CDWordEntity>))
    
}

protocol MDReadWordByCourseUUIDAndWordTextProtocol {
    
    func readWord(byCourseUUID courseUUID: UUID,
                  andWordText wordText: String,
                  _ completionHandler: @escaping(MDOperationResultWithCompletion<CDWordEntity>))
    
}

protocol MDReadWordsByCourseUUIDAndFetchLimitAndFetchOffsetProtocol {
    
    func readWords(byCourseUUID uuid: UUID,
                   fetchLimit: Int,
                   fetchOffset: Int,
                   ascending: Bool,
                   _ completionHandler: @escaping(MDOperationsResultWithCompletion<CDWordEntity>))
    
}

protocol MDReadWordsWithFetchLimitAndFetchOffsetProtocol {
    
    func readWords(fetchLimit: Int,
                   fetchOffset: Int,
                   ascending: Bool,
                   _ completionHandler: @escaping(MDOperationsResultWithCompletion<CDWordEntity>))
    
}

protocol MDReadAllWordsByCourseUUIDProtocol {
    
    func readAllWords(byCourseUUID uuid: UUID,
                      ascending: Bool,
                      _ completionHandler: @escaping(MDOperationsResultWithCompletion<CDWordEntity>))
    
}

protocol MDReadAllWordsProtocol {
    
    func readAllWords(ascending: Bool,
                      _ completionHandler: @escaping(MDOperationsResultWithCompletion<CDWordEntity>))
    
}

protocol MDReadWordProtocol: MDReadWordByWordUUIDProtocol,
                             MDReadWordByCourseUUIDAndWordTextProtocol,
                             MDReadWordsByCourseUUIDAndFetchLimitAndFetchOffsetProtocol,
                             MDReadWordsWithFetchLimitAndFetchOffsetProtocol,
                             MDReadAllWordsByCourseUUIDProtocol,
                             MDReadAllWordsProtocol {
    
}
