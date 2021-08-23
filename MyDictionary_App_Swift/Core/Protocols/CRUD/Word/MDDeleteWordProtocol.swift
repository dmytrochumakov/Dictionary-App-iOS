//
//  MDDeleteWordProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

protocol MDDeleteWordProtocol {
    func deleteWord(_ word: WordEntity, _ completionHandler: @escaping(MDEntityResult<WordEntity>))
    func deleteAllWords(_ completionHandler: @escaping(MDEntityResult<Void>))
}
