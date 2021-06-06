//
//  MainTabBarModule.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 04.06.2021.
//

import UIKit

struct MainTabBarModuleSender {
    let wordListVC: UIViewController
    let settingsVC: UIViewController
}

protocol MainTabBarModuleProtocol: ModuleProtocol {
    
}

final class MainTabBarModule: MainTabBarModuleProtocol {
    
    fileprivate let sender: MainTabBarModuleSender
    
    init(sender: MainTabBarModuleSender) {
        self.sender = sender
    }
    
}

extension MainTabBarModule {
    
    var module: UIViewController {
        // Main Tab Bar Module Classes
        let selectedMainTabBarItem: MainTabBarItem = .wordList
        let wordListModule: MainTabBarAddModuleModel = .init(mainTabBarItem: .wordList,
                                                             viewController: UINavigationController.init(rootViewController: sender.wordListVC))
        let settingsModule: MainTabBarAddModuleModel = .init(mainTabBarItem: .settings,
                                                             viewController: UINavigationController.init(rootViewController: sender.settingsVC) )
        let modules: [MainTabBarAddModuleModel] = [wordListModule, settingsModule]
        var mainTabBarInteractor: MainTabBarInteractorProtocol = MainTabBarInteractor.init(mainTabBarItems: modules.map({ $0.mainTabBarItem }),
                                                                                           modules: modules,
                                                                                           selectedMainTabBarItem: selectedMainTabBarItem)
        var mainTabBarRouter: MainTabBarRouterProtocol = MainTabBarRouter.init()
        let mainTabBarPresenter: MainTabBarPresenterProtocol = MainTabBarPresenter.init(interactor: mainTabBarInteractor,
                                                                                        router: mainTabBarRouter)
        let mainTabBarVC = MainTabBarController.init(presenter: mainTabBarPresenter)
        
        // Main Tab Bar Module
        mainTabBarPresenter.presenterOutput = mainTabBarVC
        mainTabBarInteractor.interactorOutput = mainTabBarPresenter        
        mainTabBarRouter.mainTabBarController = mainTabBarVC
        
        return mainTabBarVC
    }
    
}
