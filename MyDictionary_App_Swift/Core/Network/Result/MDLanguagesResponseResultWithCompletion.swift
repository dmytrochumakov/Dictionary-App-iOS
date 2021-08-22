//
//  MDLanguagesResponseResultWithCompletion.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 22.08.2021.
//

import Foundation

typealias MDLanguagesResponseResultWithCompletion = ((Result<[LanguageEntity], Error>) -> Void)
