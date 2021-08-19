//
//  MDStorageResult.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 19.08.2021.
//

import Foundation

struct MDStorageResult<Result> {
    let storageType: MDStorageType
    let result: Result
}

typealias MDStorageResultsWithoutCompletion<Result> = [MDStorageResult<Result>]

typealias MDStorageResultsWithCompletion<Result> = ((MDStorageResultsWithoutCompletion<Result>) -> Void)
