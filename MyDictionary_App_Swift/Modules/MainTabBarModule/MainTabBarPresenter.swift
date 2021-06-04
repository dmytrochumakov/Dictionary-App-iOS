//
//  MainTabBarPresenter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 03.06.2021.

import UIKit

protocol MainTabBarPresenterInputProtocol: UITabBarControllerDelegate {
    var modules: [MainTabBarAddModuleModel] { get }
    var selectedMainTabBarItem: MainTabBarItem { get }
}

protocol MainTabBarPresenterOutputProtocol: AnyObject {
    
}

protocol MainTabBarPresenterProtocol: MainTabBarPresenterInputProtocol,
                                      MainTabBarInteractorOutputProtocol {
    var presenterOutput: MainTabBarPresenterOutputProtocol? { get set }
}

final class MainTabBarPresenter: NSObject,
                                 MainTabBarPresenterProtocol {
    
    fileprivate let interactor: MainTabBarInteractorInputProtocol
    let router: MainTabBarRouterProtocol
    
    internal weak var presenterOutput: MainTabBarPresenterOutputProtocol?
    internal var modules: [MainTabBarAddModuleModel] {
        return interactor.modules
    }
    var selectedMainTabBarItem: MainTabBarItem {
        return interactor.selectedMainTabBarItem
    }
    
    init(interactor: MainTabBarInteractorInputProtocol,
         router: MainTabBarRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init()
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - MainTabBarInteractorOutputProtocol
extension MainTabBarPresenter {
    
}

// MARK: - UITabBarControllerDelegate
extension MainTabBarPresenter {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        interactor.didSelectViewController(tabBarControllerSelectedIndex: tabBarController.selectedIndex)
    }
    
}
