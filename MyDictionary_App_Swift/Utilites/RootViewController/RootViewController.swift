//
//  RootViewController.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 04.06.2021.
//

import UIKit

struct RootViewController {
    
    static func viewController(isLoggedIn: Bool) -> UIViewController {
        if (isLoggedIn) {
            return MDNavigationController.init(rootViewController: CourseListModule.init().module)
        } else {
            return MDNavigationController.init(rootViewController: ChoiceAuthenticationOrRegistrationModule.init().module)
        }
    }
    
}
