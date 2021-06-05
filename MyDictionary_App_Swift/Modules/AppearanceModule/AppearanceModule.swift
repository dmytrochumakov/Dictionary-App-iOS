//
//  AppearanceModule.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 04.06.2021.
//

import UIKit

protocol AppearanceModuleProtocol: ModuleProtocol {
    
}

final class AppearanceModule: AppearanceModuleProtocol {
    
}

extension AppearanceModule {
    
    var module: UIViewController {
        // Appearance Module Classes
        let appearanceDataProvider: AppearanceDataProviderProtocol = AppearanceDataProvider.init()
        let appearanceCollectionViewDelegate: AppearanceCollectionViewDelegateProtocol = AppearanceCollectionViewDelegate.init(dataProvider: appearanceDataProvider)
        let appearanceCollectionViewDataSource: AppearanceCollectionViewDataSourceProtocol = AppearanceCollectionViewDataSource.init(dataProvider: appearanceDataProvider)
        var appearanceDataManager: AppearanceDataManagerProtocol = AppearanceDataManager.init(dataProvider: appearanceDataProvider)
        let appearanceInteractor: AppearanceInteractorProtocol = AppearanceInteractor.init(dataManager: appearanceDataManager,
                                                                                           appearanceCollectionViewDelegate: appearanceCollectionViewDelegate,
                                                                                           appearanceCollectionViewDataSource: appearanceCollectionViewDataSource)
        let appearanceRouter = AppearanceRouter.init()
        let appearancePresenter: AppearancePresenterProtocol = AppearancePresenter.init(interactor: appearanceInteractor,
                                                                                        router: appearanceRouter)
        let appearanceVC = AppearanceViewController.init(presenter: appearancePresenter)
        
        // Appearance Module
        appearancePresenter.presenterOutput = appearanceVC
        appearanceInteractor.interactorOutput = appearancePresenter
        appearanceDataManager.dataManagerOutput = appearanceInteractor
        appearanceRouter.appearanceViewController = appearanceVC
        
        return appearanceVC
    }
    
}
