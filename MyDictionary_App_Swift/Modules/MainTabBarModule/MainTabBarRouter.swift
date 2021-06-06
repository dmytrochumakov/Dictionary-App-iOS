//
//  MainTabBarRouter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 03.06.2021.

import UIKit

protocol MainTabBarRouterProtocol {
    var mainTabBarController: UIViewController! { get set }
}

final class MainTabBarRouter: MainTabBarRouterProtocol {
    
    internal weak var mainTabBarController: UIViewController!    
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
