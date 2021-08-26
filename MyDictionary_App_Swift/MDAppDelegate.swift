//
//  MDAppDelegate.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 03.06.2021.
//

import UIKit

protocol MDAppDelegateProtocol {
    var rootWindow: UIWindow! { get }
    var dependencies: MDAppDependenciesProtocol! { get }
}

@main
final class MDAppDelegate: UIResponder,
                           UIApplicationDelegate,
                           MDAppDelegateProtocol {
    
    var rootWindow: UIWindow!
    var dependencies: MDAppDependenciesProtocol!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.dependencies = MDAppDependencies.init()
        self.rootWindow = RootWindow.window(isLoggedIn: self.dependencies.appSettings.isLoggedIn)
        self.dependencies.rootWindow = self.rootWindow
        
        return true
    }
    
}
