//
//  MDUpdateWordProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

protocol MDUpdateWordProtocol {
    func updateWord(byID id: Int64, word: String, word_description: String, _ completionHandler: @escaping(MDWordResult))
}
