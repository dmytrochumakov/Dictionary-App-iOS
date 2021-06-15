//
//  MDReadWordProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

protocol MDReadWordProtocol {
    func readWord(fromUUID uuid: UUID, _ completionHandler: @escaping(MDReadWordResult))
}
