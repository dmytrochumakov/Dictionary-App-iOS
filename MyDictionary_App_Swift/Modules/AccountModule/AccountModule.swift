//
//  AccountModule.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 21.09.2021.

import UIKit

final class AccountModule {
    
    let sender: Any?
    
    init(sender: Any?) {
        self.sender = sender
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension AccountModule {
    
    var module: UIViewController {
        let dataProvider: AccountDataProviderProtocol = AccountDataProvider.init()
        var dataManager: AccountDataManagerProtocol = AccountDataManager.init(dataProvider: dataProvider)
        
        let interactor: AccountInteractorProtocol = AccountInteractor.init(dataManager: dataManager)
        var router: AccountRouterProtocol = AccountRouter.init()
        let presenter: AccountPresenterProtocol = AccountPresenter.init(interactor: interactor, router: router)
        let vc = AccountViewController.init(presenter: presenter)
        
        presenter.presenterOutput = vc
        interactor.interactorOutput = presenter
        dataManager.dataManagerOutput = interactor
        router.presenter = vc
        
        return vc
    }
    
}
