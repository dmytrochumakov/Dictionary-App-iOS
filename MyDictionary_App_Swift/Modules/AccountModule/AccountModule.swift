//
//  AccountModule.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 21.09.2021.

import UIKit

final class AccountModule {
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension AccountModule {
    
    var module: UIViewController {
        
        var dataManager: AccountDataManagerProtocol = AccountDataManager.init(userMemoryStorage: MDConstants.AppDependencies.dependencies.userStorage.memoryStorage,
                                                                              dataProvider: AccountDataProvider.init())
        
        let interactor: AccountInteractorProtocol = AccountInteractor.init(dataManager: dataManager,
                                                                           storageCleanupService: MDStorageCleanupService.init(jwtStorage: MDConstants.AppDependencies.dependencies.jwtStorage,
                                                                                                                               userStorage: MDConstants.AppDependencies.dependencies.userStorage,
                                                                                                                               languageStorage: MDConstants.AppDependencies.dependencies.languageStorage,
                                                                                                                               courseStorage: MDConstants.AppDependencies.dependencies.courseStorage,
                                                                                                                               wordStorage: MDConstants.AppDependencies.dependencies.wordStorage,
                                                                                                                               operationQueue: MDConstants.AppDependencies.dependencies.operationQueueManager.operationQueue(byName: MDConstants.QueueName.storageCleanupServiceOperationQueue)!),
                                                                           appSettings: MDConstants.AppDependencies.dependencies.appSettings,
                                                                           apiAccount: MDConstants.AppDependencies.dependencies.apiAccount,
                                                                           jwtMemoryStorage: MDConstants.AppDependencies.dependencies.jwtStorage.memoryStorage)
        
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
