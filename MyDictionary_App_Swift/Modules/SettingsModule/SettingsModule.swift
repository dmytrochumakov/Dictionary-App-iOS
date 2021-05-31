//
//  SettingsModule.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 31.05.2021.

import UIKit

final class SettingsModule {
    
    let sender: Any?
    
    init(sender: Any?) {
        self.sender = sender
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension SettingsModule {
    
    var module: UIViewController {
        let dataProvider: SettingsDataProviderProtocol = SettingsDataProvider.init()
        var dataManager: SettingsDataManagerProtocol = SettingsDataManager.init(dataProvider: dataProvider)
        
        let interactor: SettingsInteractorProtocol = SettingsInteractor.init(dataManager: dataManager)
        var router: SettingsRouterProtocol = SettingsRouter.init()
        let presenter: SettingsPresenterProtocol = SettingsPresenter.init(interactor: interactor, router: router)
        let vc = SettingsViewController.init(presenter: presenter)
        
        presenter.presenterOutput = vc
        interactor.interactorOutput = presenter
        dataManager.dataManagerOutput = interactor
        router.presenter = vc
        
        return vc
    }
    
}
