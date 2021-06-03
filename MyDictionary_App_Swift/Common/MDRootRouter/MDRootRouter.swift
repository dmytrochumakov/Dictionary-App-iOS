//
//  MDRootRouter.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 03.06.2021.
//

import UIKit

protocol MDRootRouterProtocol {
    func showRootViewController(_ viewController: UIViewController, inWindow window: UIWindow)
}

final class MDRootRouter: NSObject,
                          MDRootRouterProtocol {
    
    func showRootViewController(_ viewController: UIViewController, inWindow window: UIWindow) {
        let navigationController: UINavigationController? = self.navigationControllerFromWindow(window)
        navigationController?.viewControllers = [viewController]
    }
    
    func navigationControllerFromWindow(_ window: UIWindow) -> UINavigationController? {
        guard let rootViewController = window.rootViewController else { return nil }
        return UINavigationController.init(rootViewController: rootViewController)
    }
    
}
