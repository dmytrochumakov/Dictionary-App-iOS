//
//  MDReadWordsResult.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import Foundation

typealias MDReadWordsResult = ((Result<[WordModel], Error>) -> Void)
