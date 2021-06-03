//
//  AppearanceRouter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 03.06.2021.

import UIKit

protocol AppearanceRouterProtocol {
    var appearanceViewController: UIViewController! { get set }
    func pushInterfaceFromViewController(_ viewController: UIViewController)
    func popAppearanceInterface()
}

final class AppearanceRouter: AppearanceRouterProtocol {
    
    internal weak var appearanceViewController: UIViewController!    
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension AppearanceRouter {
    
    func pushInterfaceFromViewController(_ viewController: UIViewController) {
        viewController.navigationController?.pushViewController(appearanceViewController, animated: true)
    }
    
    func popAppearanceInterface() {
        self.appearanceViewController.navigationController?.popViewController(animated: true)
    }
    
}
