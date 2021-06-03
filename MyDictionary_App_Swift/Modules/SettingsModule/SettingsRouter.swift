//
//  SettingsRouter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 31.05.2021.

import UIKit

protocol SettingsRouterProtocol {
    var appearanceRouter: AppearanceRouter! { get set }
    var settingsViewController: UIViewController! { get set }
    func showAppearanceList()
}

final class SettingsRouter: SettingsRouterProtocol {
    
    internal weak var appearanceRouter: AppearanceRouter!
    internal weak var settingsViewController: UIViewController!    
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension SettingsRouter {
    
    func showAppearanceList() {
        appearanceRouter.pushInterfaceFromViewController(settingsViewController)
    }
    
}
