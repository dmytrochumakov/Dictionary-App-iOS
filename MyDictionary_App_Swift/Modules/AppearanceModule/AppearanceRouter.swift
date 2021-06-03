//
//  AppearanceRouter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 03.06.2021.

import UIKit

protocol AppearanceRouterProtocol {
    var appearanceViewController: UIViewController! { get set }
}

final class AppearanceRouter: AppearanceRouterProtocol {
    
    internal weak var appearanceViewController: UIViewController!    
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
