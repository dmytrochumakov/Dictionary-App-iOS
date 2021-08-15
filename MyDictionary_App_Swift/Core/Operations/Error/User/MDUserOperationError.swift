//
//  MDUserOperationError.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

enum MDUserOperationError: Error {
    case cantFindUser
    case objectRemovedFromMemory
}
