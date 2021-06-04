//
//  SettingsModule.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 04.06.2021.
//

import UIKit

protocol SettingsModuleProtocol: ModuleProtocol {
    
}

final class SettingsModule: SettingsModuleProtocol {
        
    
}

extension SettingsModule {
    
    var module: UIViewController {
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
        return settingsVC
    }
    
}
