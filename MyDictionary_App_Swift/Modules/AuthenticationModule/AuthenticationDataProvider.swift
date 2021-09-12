//
//  AuthenticationDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 12.08.2021.

import Foundation

protocol AuthenticationDataProviderProtocol: AuthValidationDataProviderProtocol {
    
}

final class AuthenticationDataProvider: AuthenticationDataProviderProtocol {
    
    internal var nickname: String?
    internal var password: String?
    
}
