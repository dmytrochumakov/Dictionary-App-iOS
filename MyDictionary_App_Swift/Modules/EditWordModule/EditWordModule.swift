//
//  EditWordModule.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 28.09.2021.

import UIKit

final class EditWordModule {
    
    let sender: WordResponse
    
    init(sender: WordResponse) {
        self.sender = sender
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension EditWordModule {
    
    var module: UIViewController {
        let dataProvider: EditWordDataProviderProtocol = EditWordDataProvider.init(word: sender,
                                                                                   editButtonIsSelected: false)
        var dataManager: EditWordDataManagerProtocol = EditWordDataManager.init(dataProvider: dataProvider)
        
        let interactor: EditWordInteractorProtocol = EditWordInteractor.init(dataManager: dataManager,
                                                                             wordManager: MDWordManager.init(jwtManager: MDJWTManager.init(userMemoryStorage: MDConstants.AppDependencies.dependencies.userStorage.memoryStorage,
                                                                                                                                           jwtStorage: MDConstants.AppDependencies.dependencies.jwtStorage,
                                                                                                                                           apiJWT: MDConstants.AppDependencies.dependencies.apiJWT),
                                                                                                             apiWord: MDConstants.AppDependencies.dependencies.apiWord,
                                                                                                             wordStorage: MDConstants.AppDependencies.dependencies.wordStorage),
                                                                             bridge: MDConstants.AppDependencies.dependencies.bridge)
        var router: EditWordRouterProtocol = EditWordRouter.init()
        let presenter: EditWordPresenterProtocol = EditWordPresenter.init(interactor: interactor, router: router)
        let vc = EditWordViewController.init(presenter: presenter)
        
        presenter.presenterOutput = vc
        interactor.interactorOutput = presenter
        dataManager.dataManagerOutput = interactor
        router.presenter = vc
        
        return vc
    }
    
}
