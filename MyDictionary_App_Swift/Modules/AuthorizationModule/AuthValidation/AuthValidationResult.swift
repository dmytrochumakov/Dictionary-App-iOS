//
//  AuthValidationResult.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.08.2021.
//

import Foundation

struct AuthValidationResult {
    let validationType: AuthValidationType
    let validationError: AuthValidationError?
}
