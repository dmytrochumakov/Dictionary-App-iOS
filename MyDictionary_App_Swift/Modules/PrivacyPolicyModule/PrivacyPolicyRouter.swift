//
//  PrivacyPolicyRouter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 21.09.2021.

import UIKit

protocol PrivacyPolicyRouterProtocol {
    var presenter: UIViewController? { get set }
}

final class PrivacyPolicyRouter: PrivacyPolicyRouterProtocol {
    
    internal weak var presenter: UIViewController?
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
