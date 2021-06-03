//
//  MDAppDelegate.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 03.06.2021.
//

import UIKit

protocol MDAppDelegateProtocol {
    var rootWindow: UIWindow! { get }
}

@main
final class MDAppDelegate: UIResponder,
                           UIApplicationDelegate,
                           MDAppDelegateProtocol {
    
    var rootWindow: UIWindow!
    var dependencies: MDAppDependenciesProtocol!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window: UIWindow = .init(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.rootWindow = window
        let dependencies: MDAppDependenciesProtocol = MDAppDependencies.init()
        self.dependencies = dependencies;
        self.dependencies.installRootViewControllerIntoWindow(rootWindow)
        
        return true
    }
    
}
