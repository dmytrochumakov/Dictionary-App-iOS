//
//  MDStorageServiceOperationResult.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 22.09.2021.
//

import Foundation

struct MDStorageServiceOperationResult {
    let storageServiceType: MDStorageServiceType
    let result: MDOperationResultWithoutCompletion<Void>
}
