//
//  MainTabBarController.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import UIKit

struct MainTabBarAddModuleModel {
    let mainTabBarItem: MainTabBarItem
    let viewController: UIViewController
}

final class MainTabBarController: UITabBarController {
          
    fileprivate let presenter: MainTabBarPresenterInputProtocol

    init(presenter: MainTabBarPresenterInputProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - MainTabBarPresenterOutputProtocol
extension MainTabBarController: MainTabBarPresenterOutputProtocol {
       
}

// MARK: - Setup
fileprivate extension MainTabBarController {
    
    func setup() {
        self.delegate = presenter
        setupControllers()
    }
    
    func setupControllers() {
        self.viewControllers = presenter.modules.map({ $0.viewController })
        self.selectedIndex = presenter.selectedMainTabBarItem.rawValue
    }
    
}
