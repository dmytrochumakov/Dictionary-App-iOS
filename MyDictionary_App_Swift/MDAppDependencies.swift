//
//  MDAppDependencies.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 03.06.2021.
//

import UIKit

protocol MDAppDependenciesProtocol {
    func installRootViewControllerIntoWindow(_ window: UIWindow)
}

final class MDAppDependencies: NSObject,
                               MDAppDependenciesProtocol {
    
    fileprivate var mainTabBarRouter: MainTabBarRouterProtocol!
    
    override init() {
        super.init()
        self.configureDependencies()
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDAppDependencies {
    
    func installRootViewControllerIntoWindow(_ window: UIWindow) {
        mainTabBarRouter.presentMainTabBarInterfaceFromWindow(window)
    }
    
}

// MARK: - Configure Dependencies
fileprivate extension MDAppDependencies {
    
    func configureDependencies() {
        // Root Level Classes
        let rootRouter = MDRootRouter.init()
        
        // Word List Module Classes
        let wordListDataProvider: WordListDataProviderProcotol = WordListDataProvider.init()
        var wordListDataManager: WordListDataManagerProtocol = WordListDataManager.init(dataProvider: wordListDataProvider)
        let wordListCollectionViewDelegate: WordListCollectionViewDelegateProtocol = WordListCollectionViewDelegate.init(dataProvider: wordListDataProvider)
        let wordListCollectionViewDataSource: WordListCollectionViewDataSourceProtocol = WordListCollectionViewDataSource.init(dataProvider: wordListDataProvider)
        
        let wordListInteractor: WordListInteractorProtocol = WordListInteractor.init(dataManager: wordListDataManager,
                                                                                     collectionViewDelegate: wordListCollectionViewDelegate,
                                                                                     collectionViewDataSource: wordListCollectionViewDataSource)
        var wordListRouter: WordListRouterProtocol = WordListRouter.init()
        let wordListPresenter: WordListPresenterProtocol = WordListPresenter.init(interactor: wordListInteractor,
                                                                                  router: wordListRouter)
        let wordListVC = WordListViewController.init(presenter: wordListPresenter)
        
        // Word List Module
        wordListPresenter.presenterOutput = wordListVC
        wordListInteractor.interactorOutput = wordListPresenter
        wordListDataManager.dataManagerOutput = wordListInteractor
        wordListRouter.wordListViewController = wordListVC
        // --------------------------------------------------------------------------------------------------------------------------------------- //
        
        // Settings Module Classes
        let settingsDataProviderModel: SettingsDataProviderModel = .init(sections: [.init(sectionType: .list,
                                                                                          rows: [.init(rowType: .appearance,
                                                                                                       titleText: KeysForTranslate.appearance.localized)])])
        let settingsDataProvider: SettingsDataProviderProtocol = SettingsDataProvider.init(model: settingsDataProviderModel)
        var settingsDataManager: SettingsDataManagerProtocol = SettingsDataManager.init(dataProvider: settingsDataProvider)
        let settingsCollectionViewDelegate: SettingsCollectionViewDelegateProtocol = SettingsCollectionViewDelegate.init(dataProvider: settingsDataProvider)
        let settingsCollectionViewDataSource: SettingsCollectionViewDataSourceProtocol = SettingsCollectionViewDataSource.init(dataProvider: settingsDataProvider)
        let settingsInteractor: SettingsInteractorProtocol = SettingsInteractor.init(dataManager: settingsDataManager,
                                                                                     collectionViewDelegate: settingsCollectionViewDelegate,
                                                                                     collectionViewDataSource: settingsCollectionViewDataSource)
        var settingsRouter: SettingsRouterProtocol = SettingsRouter.init()
        let settingsPresenter: SettingsPresenterProtocol = SettingsPresenter.init(interactor: settingsInteractor,
                                                                                  router: settingsRouter)
        let settingsVC = SettingsViewController.init(presenter: settingsPresenter)
        
        // Settings Module
        settingsPresenter.presenterOutput = settingsVC
        settingsInteractor.interactorOutput = settingsPresenter
        settingsDataManager.dataManagerOutput = settingsInteractor
        settingsRouter.settingsViewController = settingsVC
        // --------------------------------------------------------------------------------------------------------------------------------------- //
        
        // Appearance Module Classes
        let appearanceDataProvider: AppearanceDataProviderProtocol = AppearanceDataProvider.init()
        var appearanceDataManager: AppearanceDataManagerProtocol = AppearanceDataManager.init(dataProvider: appearanceDataProvider)
        let appearanceInteractor: AppearanceInteractorProtocol = AppearanceInteractor.init(dataManager: appearanceDataManager)
        var appearanceRouter: AppearanceRouterProtocol = AppearanceRouter.init()
        let appearancePresenter: AppearancePresenterProtocol = AppearancePresenter.init(interactor: appearanceInteractor,
                                                                                        router: appearanceRouter)
        let appearanceVC = AppearanceViewController.init(presenter: appearancePresenter)
        
        // Appearance Module
        appearancePresenter.presenterOutput = appearanceVC
        appearanceInteractor.interactorOutput = appearancePresenter
        appearanceDataManager.dataManagerOutput = appearanceInteractor
        appearanceRouter.appearanceViewController = appearanceVC
        // --------------------------------------------------------------------------------------------------------------------------------------- //
        
        // Main Tab Bar Module Classes
        let selectedMainTabBarItem: MainTabBarItem = .wordList
        let wordListModule: MainTabBarAddModuleModel = .init(mainTabBarItem: .wordList,
                                                             viewController: wordListVC)
        let settingsModule: MainTabBarAddModuleModel = .init(mainTabBarItem: .settings,
                                                             viewController: settingsVC)
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
        mainTabBarRouter.rootRouter = rootRouter
        mainTabBarRouter.mainTabBarController = mainTabBarVC
        
        self.mainTabBarRouter = mainTabBarRouter
        // --------------------------------------------------------------------------------------------------------------------------------------- //
        // Set Router
        settingsRouter.appearanceRouter = appearanceRouter as? AppearanceRouter
        //
    }
    
}
