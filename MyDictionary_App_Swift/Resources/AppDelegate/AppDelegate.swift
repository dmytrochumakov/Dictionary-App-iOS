//
//  AppDelegate.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 10.05.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        start()
        return true
    }
    
}

// MARK: - Start
fileprivate extension AppDelegate {
    
    func start() {
        self.window = RootWindow.window
    }
    
}
