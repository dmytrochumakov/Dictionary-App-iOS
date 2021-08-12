//
//  AuthorizationRouter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 12.08.2021.

import UIKit

protocol AuthorizationRouterProtocol {
    var presenter: UIViewController? { get set }
}

final class AuthorizationRouter: AuthorizationRouterProtocol {
    
    internal weak var presenter: UIViewController?
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
