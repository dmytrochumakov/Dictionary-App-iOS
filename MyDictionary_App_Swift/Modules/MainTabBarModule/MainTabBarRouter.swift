//
//  MainTabBarRouter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 03.06.2021.

import UIKit

protocol MainTabBarRouterProtocol {
    var mainTabBarController: UIViewController! { get set }
    var rootRouter: MDRootRouter! { get set }
    func presentMainTabBarInterfaceFromWindow(_ window: UIWindow)
}

final class MainTabBarRouter: MainTabBarRouterProtocol {
    
    internal weak var mainTabBarController: UIViewController!
    internal weak var rootRouter: MDRootRouter!
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MainTabBarRouter {
    
    func presentMainTabBarInterfaceFromWindow(_ window: UIWindow) {
        self.rootRouter.showRootViewController(mainTabBarController, inWindow: window)
    }
    
}
