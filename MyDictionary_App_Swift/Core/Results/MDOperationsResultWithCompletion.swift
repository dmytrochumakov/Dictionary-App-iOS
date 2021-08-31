//
//  MDOperationsResultWithCompletion.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import Foundation

typealias MDOperationsResultWithCompletion<Operation> = ((MDOperationsResultWithoutCompletion<Operation>) -> Void)
typealias MDOperationsResultWithoutCompletion<Operation> = (Result<[Operation], Error>)
