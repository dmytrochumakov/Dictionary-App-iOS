//
//  MDUpdateWordProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

protocol MDUpdateWordProtocol {
    
    func updateWord(byWordID wordId: Int64,                    
                    newWordDescription: String,
                    _ completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
    
}
