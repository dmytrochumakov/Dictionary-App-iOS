//
//  MDWordsCountProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.07.2021.
//

import Foundation

protocol MDWordsCountProtocol {
    func wordsCount(_ completionHandler: @escaping (MDWordsCountResult))
}
