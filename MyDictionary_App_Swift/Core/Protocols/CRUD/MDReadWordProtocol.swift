//
//  MDReadWordProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

protocol MDReadWordProtocol {
    func readWord(fromID id: Int64, _ completionHandler: @escaping(MDReadWordResult))
    func readWords(fetchLimit: Int, fetchOffset: Int, _ completionHandler: @escaping(MDReadWordsResult))
    func readAllWords(_ completionHandler: @escaping(MDReadWordsResult))
}
