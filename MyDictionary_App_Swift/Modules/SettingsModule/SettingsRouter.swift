//
//  SettingsRouter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 31.05.2021.

import UIKit

protocol SettingsRouterProtocol {
    var settingsViewController: UIViewController! { get set }
}

final class SettingsRouter: SettingsRouterProtocol {
    
    internal weak var settingsViewController: UIViewController!    
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
