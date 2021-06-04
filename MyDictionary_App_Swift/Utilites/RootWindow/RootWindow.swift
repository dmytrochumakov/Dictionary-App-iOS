//
//  RootWindow.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 04.06.2021.
//

import UIKit

struct RootWindow {
    
    static var window: UIWindow {
        let window: UIWindow = UIWindow.init(frame: UIScreen.main.bounds)
        window.rootViewController = RootViewController.viewController
        window.makeKeyAndVisible()
        return window
    }
    
}
