//
//  RootViewController.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import UIKit

struct RootViewController {
    
    static var viewController: UIViewController {        
        return UINavigationController.init(rootViewController: TestViewController.init()) 
    }
    
}

final class TestViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white        
    }
}
