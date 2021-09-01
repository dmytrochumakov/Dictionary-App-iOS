//
//  MDSyncResult.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 01.09.2021.
//

import Foundation

struct MDSyncResult {
    let syncStep: MDSyncStep
    let result: MDOperationResultWithoutCompletion<Void>
}
