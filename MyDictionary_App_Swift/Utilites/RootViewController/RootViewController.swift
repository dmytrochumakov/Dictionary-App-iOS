//
//  RootViewController.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import UIKit

struct RootViewController {
    
    static var viewController: UIViewController {        
        return UINavigationController.init(rootViewController: WordListModule.init(sender: nil).module) 
    }
    
}
