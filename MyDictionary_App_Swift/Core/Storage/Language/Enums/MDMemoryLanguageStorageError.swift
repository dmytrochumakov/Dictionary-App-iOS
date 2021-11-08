//
//  MDMemoryLanguageStorageError.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.11.2021.
//

import Foundation

enum MDMemoryLanguageStorageError: Error {
    case invalidPath
    case languageWithThisIDDoesNotExist
}
