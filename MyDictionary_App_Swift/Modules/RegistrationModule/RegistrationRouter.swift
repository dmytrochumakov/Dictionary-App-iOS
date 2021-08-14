//
//  RegistrationRouter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 14.08.2021.

import UIKit

protocol RegistrationRouterProtocol {
    var presenter: UIViewController? { get set }
}

final class RegistrationRouter: RegistrationRouterProtocol {
    
    internal weak var presenter: UIViewController?
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
