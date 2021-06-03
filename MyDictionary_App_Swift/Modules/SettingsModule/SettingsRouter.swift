//
//  SettingsRouter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 31.05.2021.

import UIKit

protocol SettingsRouterProtocol {
    var settingsViewController: UIViewController! { get set }
    var rootRouter: MDRootRouter! { get set }
}

final class SettingsRouter: SettingsRouterProtocol {
    
    internal weak var settingsViewController: UIViewController!
    internal weak var rootRouter: MDRootRouter!
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
