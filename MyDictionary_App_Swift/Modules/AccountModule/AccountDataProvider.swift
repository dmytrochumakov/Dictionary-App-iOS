//
//  AccountDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 21.09.2021.

import Foundation

protocol AccountDataProviderProtocol {
    var user: UserResponse? { get set }
}

final class AccountDataProvider: AccountDataProviderProtocol {
    
    var user: UserResponse?
    
}
