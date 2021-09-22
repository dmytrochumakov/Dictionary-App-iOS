//
//  AccountRouter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 21.09.2021.

import UIKit

protocol AccountRouterProtocol {
    var presenter: UIViewController? { get set }
    func showChoiceAuthenticationOrRegistration()
}

final class AccountRouter: AccountRouterProtocol {
    
    internal weak var presenter: UIViewController?
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension AccountRouter {
    
    func showChoiceAuthenticationOrRegistration() {
        MDConstants.AppDependencies.dependencies.rootWindow.rootViewController = RootViewController.viewController(isLoggedIn: false)
    }
    
}
