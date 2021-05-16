//
//  RootWindow.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import UIKit

struct RootWindow {
    
    static var window: UIWindow {
        let window: UIWindow = .init(frame: UIScreen.main.bounds)
        window.rootViewController = RootViewController.viewController
        window.makeKeyAndVisible()
        return window
    }
    
}
