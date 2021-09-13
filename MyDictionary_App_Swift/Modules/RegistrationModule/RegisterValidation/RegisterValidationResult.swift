//
//  RegisterValidationResult.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.09.2021.
//

import Foundation

struct RegisterValidationResult {
    let validationType: RegisterValidationType
    let validationError: RegisterValidationError?
}
