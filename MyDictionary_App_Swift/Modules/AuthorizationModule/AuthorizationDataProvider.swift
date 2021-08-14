//
//  AuthorizationDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 12.08.2021.

import Foundation

protocol AuthorizationDataProviderProtocol: AuthValidationDataProviderProtocol {
    
}

final class AuthorizationDataProvider: AuthorizationDataProviderProtocol {
    
    internal var nickname: String?
    internal var password: String?
    
}
