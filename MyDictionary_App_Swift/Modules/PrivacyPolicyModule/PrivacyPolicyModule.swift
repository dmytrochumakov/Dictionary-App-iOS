//
//  PrivacyPolicyModule.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 21.09.2021.

import UIKit

final class PrivacyPolicyModule {
    
    let sender: Any?
    
    init(sender: Any?) {
        self.sender = sender
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension PrivacyPolicyModule {
    
    var module: UIViewController {
        let dataProvider: PrivacyPolicyDataProviderProtocol = PrivacyPolicyDataProvider.init()
        var dataManager: PrivacyPolicyDataManagerProtocol = PrivacyPolicyDataManager.init(dataProvider: dataProvider)
        
        let interactor: PrivacyPolicyInteractorProtocol = PrivacyPolicyInteractor.init(dataManager: dataManager)
        var router: PrivacyPolicyRouterProtocol = PrivacyPolicyRouter.init()
        let presenter: PrivacyPolicyPresenterProtocol = PrivacyPolicyPresenter.init(interactor: interactor, router: router)
        let vc = PrivacyPolicyViewController.init(presenter: presenter)
        
        presenter.presenterOutput = vc
        interactor.interactorOutput = presenter
        dataManager.dataManagerOutput = interactor
        router.presenter = vc
        
        return vc
    }
    
}
