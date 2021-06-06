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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.rootWindow = RootWindow.window
        
        return true
    }
    
}
