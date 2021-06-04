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
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
}
