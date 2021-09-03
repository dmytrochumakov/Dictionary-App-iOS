//
//  MDDeleteWordProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

protocol MDDeleteWordProtocol {
    
    func deleteWord(byWordId wordId: Int64,
                    _ completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
    
    func deleteAllWords(_ completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
    
}
