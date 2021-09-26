//
//  SettingsModule.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 04.06.2021.
//

import UIKit

final class SettingsModule {
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension SettingsModule {
    
    var module: UIViewController {
        // Settings Module Classes
        
        let settingsRows: [SettingsRowModel] = [.init(rowType: .account),
                                                .init(rowType: .privacyPolicy),
                                                .init(rowType: .termsOfService),
                                                .init(rowType: .about),
                                                .init(rowType: .shareFeedback)]
        
        let settingsDataProvider: SettingsDataProviderProtocol = SettingsDataProvider.init(rows: settingsRows)
        
        var settingsDataManager: SettingsDataManagerProtocol = SettingsDataManager.init(dataProvider: settingsDataProvider)
        
        let settingsInteractor: SettingsInteractorProtocol = SettingsInteractor.init(dataManager: settingsDataManager,
                                                                                     collectionViewDelegate: SettingsCollectionViewDelegate.init(dataProvider: settingsDataProvider),
                                                                                     collectionViewDataSource: SettingsCollectionViewDataSource.init(dataProvider: settingsDataProvider))
        
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
        return settingsVC
    }
    
}
