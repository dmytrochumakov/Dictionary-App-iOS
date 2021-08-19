//
//  MDEntitiesIsEmptyResultWithCompletion.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.07.2021.
//

import Foundation

typealias MDEntitiesIsEmptyResultWithCompletion = ((MDEntitiesIsEmptyResultWithoutCompletion) -> Void)
typealias MDEntitiesIsEmptyResultWithoutCompletion = (Result<Bool, Error>)
