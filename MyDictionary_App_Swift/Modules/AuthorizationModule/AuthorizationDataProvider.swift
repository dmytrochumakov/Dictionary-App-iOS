//
//  AuthorizationDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 12.08.2021.

import Foundation

protocol AuthorizationDataProviderProtocol {
    var nickname: String? { get set }
    var password: String? { get set }
}

final class AuthorizationDataProvider: AuthorizationDataProviderProtocol {
    
    internal var nickname: String?
    internal var password: String?
    
}
