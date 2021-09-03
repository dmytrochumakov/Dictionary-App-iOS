//
//  MDDeleteLanguageProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

protocol MDDeleteLanguageProtocol {
    func deleteAllLanguages(_ completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
}
