//
//  RootViewController.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 04.06.2021.
//

import UIKit

struct RootViewController {
    
    static var viewController: UIViewController {
        return UINavigationController.init(rootViewController: CourseListModule.init(sender: nil).module)
    }
    
}
