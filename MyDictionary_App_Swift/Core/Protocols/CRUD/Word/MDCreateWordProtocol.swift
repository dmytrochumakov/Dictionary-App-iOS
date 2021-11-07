//
//  MDCreateWordProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

protocol MDCreateWordProtocol {
    
    func createWord(_ wordModel: CDWordEntity,
                    _ completionHandler: @escaping(MDOperationResultWithCompletion<CDWordEntity>))
    
    func createWords(_ wordModels: [CDWordEntity],
                     _ completionHandler: @escaping(MDOperationsResultWithCompletion<CDWordEntity>))
    
}
