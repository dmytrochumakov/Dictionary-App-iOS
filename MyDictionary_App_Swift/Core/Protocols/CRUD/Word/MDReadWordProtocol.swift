//
//  MDReadWordProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

protocol MDReadWordProtocol {
    
    func readWord(fromWordID wordId: Int64,
                  _ completionHandler: @escaping(MDEntityResult<WordResponse>))
    
    func readWords(fetchLimit: Int,
                   fetchOffset: Int,
                   _ completionHandler: @escaping(MDEntitiesResult<WordResponse>))
    
    func readAllWords(_ completionHandler: @escaping(MDEntitiesResult<WordResponse>))
    
}
