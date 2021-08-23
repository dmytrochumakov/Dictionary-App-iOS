//
//  MDReadLanguageProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

protocol MDReadLanguageProtocol {
    func readAllLanguages(_ completionHandler: @escaping(MDEntityResult<[LanguageEntity]>))
}
