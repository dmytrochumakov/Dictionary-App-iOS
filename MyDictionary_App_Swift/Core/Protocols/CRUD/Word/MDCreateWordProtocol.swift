//
//  MDCreateWordProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

protocol MDCreateWordProtocol {
    
    func createWord(_ wordModel: WordResponse,
                    _ completionHandler: @escaping(MDOperationResultWithCompletion<WordResponse>))
    
    func createWords(_ wordModels: [WordResponse],
                     _ completionHandler: @escaping(MDOperationsResultWithCompletion<WordResponse>))
    
}
