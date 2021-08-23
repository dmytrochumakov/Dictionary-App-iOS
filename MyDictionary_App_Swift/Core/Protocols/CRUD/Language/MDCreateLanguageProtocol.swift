//
//  MDCreateLanguageProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

protocol MDCreateLanguageProtocol {
    func createLanguages(_ languageEntities: [LanguageEntity], _ completionHandler: @escaping(MDEntityResult<[LanguageEntity]>))
}
