//
//  RegistrationDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 14.08.2021.

import Foundation

protocol RegistrationDataProviderProtocol: RegisterValidationDataProviderProtocol {
    
}

final class RegistrationDataProvider: RegistrationDataProviderProtocol {
 
    internal var nickname: String?
    internal var password: String?
    internal var confirmPassword: String?
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
