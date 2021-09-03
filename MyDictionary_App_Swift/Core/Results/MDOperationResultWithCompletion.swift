//
//  MDOperationResultWithCompletion.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

typealias MDOperationResultWithCompletion<Operation> = ((MDOperationResultWithoutCompletion<Operation>) -> Void)
typealias MDOperationResultWithoutCompletion<Operation> = (Result<Operation, Error>)
