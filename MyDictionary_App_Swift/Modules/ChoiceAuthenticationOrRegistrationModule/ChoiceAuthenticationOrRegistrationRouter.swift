//
//  ChoiceAuthenticationOrRegistrationRouter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 10.09.2021.

import UIKit

protocol ChoiceAuthenticationOrRegistrationRouterProtocol {
    var presenter: UIViewController? { get set }
}

final class ChoiceAuthenticationOrRegistrationRouter: ChoiceAuthenticationOrRegistrationRouterProtocol {
    
    internal weak var presenter: UIViewController?
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
