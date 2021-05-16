//
//  MainTabBarController.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    /// Default is [.wordList]
    fileprivate var mainTabBarItems: [MainTabBarItem]
    
    init() {
        self.mainTabBarItems = [.wordList]
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - UITabBarControllerDelegate
extension MainTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        configureMainTabBarItems(fromSelectedIndex: tabBarController.selectedIndex)
        
        if (checkIfItsDoubleTap()) {
            postDoubleTapNotification()
            return
        } else {
            return
        }
        
    }
    
}

// MARK: - Setup
fileprivate extension MainTabBarController {
    
    func setup() {
        self.delegate = self
        setupControllers()
    }
    
    func setupControllers() {
        let wordListModule = UINavigationController.init(rootViewController: WordListModule.init(sender: nil).module)        
        self.viewControllers = [wordListModule]
    }
    
}

// MARK: - Double Tap
fileprivate extension MainTabBarController {
    
    func checkIfItsDoubleTap() -> Bool {
        if (self.mainTabBarItems.count == 2) {
            return (self.mainTabBarItems[0] == self.mainTabBarItems[1])
        } else {
            return false
        }
    }
    
    func postDoubleTapNotification() {
        NotificationCenter.default.post(name: .mainTabBarItemDoubleTap, object: nil)        
    }
    
}

// MARK: - Configure Main Tab Bar Items
fileprivate extension MainTabBarController {

    func configureMainTabBarItems(fromSelectedIndex selectedIndex: Int) {
        guard let mainTabBarItem: MainTabBarItem = .init(rawValue: selectedIndex) else { return }
        if (self.mainTabBarItems.count == 2) {
            let secondItem = self.mainTabBarItems[1]
            self.mainTabBarItems[0] = secondItem
            self.mainTabBarItems[1] = mainTabBarItem
            return
        } else {
            self.mainTabBarItems.append(mainTabBarItem)
        }
    }
    
}
