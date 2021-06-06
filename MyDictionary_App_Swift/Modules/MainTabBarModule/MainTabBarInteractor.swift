//
//  MainTabBarInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 03.06.2021.

import UIKit

protocol MainTabBarInteractorInputProtocol {
    var mainTabBarItems: [MainTabBarItem] { get }
    var modules: [MainTabBarAddModuleModel] { get }
    var selectedMainTabBarItem: MainTabBarItem { get }
    func didSelectViewController(tabBarControllerSelectedIndex selectedIndex: Int)
}

protocol MainTabBarInteractorOutputProtocol: AnyObject {
    
}

protocol MainTabBarInteractorProtocol: MainTabBarInteractorInputProtocol {
    var interactorOutput: MainTabBarInteractorOutputProtocol? { get set }
}

final class MainTabBarInteractor: MainTabBarInteractorProtocol {
    
    internal var mainTabBarItems: [MainTabBarItem]
    internal var modules: [MainTabBarAddModuleModel]
    internal var selectedMainTabBarItem: MainTabBarItem
    internal weak var interactorOutput: MainTabBarInteractorOutputProtocol?
    
    init(mainTabBarItems: [MainTabBarItem],
         modules: [MainTabBarAddModuleModel],
         selectedMainTabBarItem: MainTabBarItem) {
        
        self.mainTabBarItems = mainTabBarItems
        self.modules = modules
        self.selectedMainTabBarItem = selectedMainTabBarItem
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MainTabBarInteractor {
    
    func didSelectViewController(tabBarControllerSelectedIndex selectedIndex: Int) {
        
        configureMainTabBarItems(fromSelectedIndex: selectedIndex)
        
        if (checkIfItsDoubleTap()) {
            postDoubleTapNotification()
            return
        } else {
            return
        }
        
    }
    
}

// MARK: - Double Tap
fileprivate extension MainTabBarInteractor {
    
    func checkIfItsDoubleTap() -> Bool {
        if (self.mainTabBarItems.count == 2) {
            return (self.mainTabBarItems[0] == self.mainTabBarItems[1])
        } else {
            return false
        }
    }
    
    func postDoubleTapNotification() {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Configure Main Tab Bar Items
fileprivate extension MainTabBarInteractor {
    
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
