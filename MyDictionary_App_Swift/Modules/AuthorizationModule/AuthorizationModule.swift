//
//  AuthorizationModule.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 12.08.2021.

import UIKit

final class AuthorizationModule {
    
    let sender: Any?
    
    init(sender: Any?) {
        self.sender = sender
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension AuthorizationModule {
    
    var module: UIViewController {
        
        let dataProvider: AuthorizationDataProviderProtocol = AuthorizationDataProvider.init()
        var dataManager: AuthorizationDataManagerProtocol = AuthorizationDataManager.init(dataProvider: dataProvider)
        
        let textFieldDelegate: AuthTextFieldDelegateProtocol = AuthTextFieldDelegate.init()
        
        let validationTypes: [AuthValidationType] = [.nickname, .password]
        let authValidation: AuthValidationProtocol = AuthValidation.init(dataProvider: dataProvider,
                                                                         validationTypes: validationTypes)                
        
        let apiAuth: MDAPIAuthProtocol = MDAPIAuth.init(requestDispatcher: Constants.RequestDispatcher.defaultRequestDispatcher(reachability: Constants.AppDependencies.dependencies.reachability),
                                                        operationQueueService: Constants.AppDependencies.dependencies.operationQueueService)
        
        let sync: SyncProtocol = Sync.init(apiJWT: Constants.AppDependencies.dependencies.apiJWT,
                                           jwtStorage: Constants.AppDependencies.dependencies.jwtStorage,
                                           apiUser: Constants.AppDependencies.dependencies.apiUser,
                                           userStorage: Constants.AppDependencies.dependencies.userStorage,
                                           apiLanguage: Constants.AppDependencies.dependencies.apiLanguage,
                                           languageStorage: Constants.AppDependencies.dependencies.languageStorage,
                                           apiCourse: Constants.AppDependencies.dependencies.apiCourse,
                                           courseStorage: Constants.AppDependencies.dependencies.courseStorage,
                                           apiWord: Constants.AppDependencies.dependencies.apiWord,
                                           wordStorage: Constants.AppDependencies.dependencies.wordStorage)
        
        let syncManager: SyncManagerProtocol = SyncManager.init(sync: sync)
        let authManager: MDAuthManagerProtocol = MDAuthManager.init(apiAuth: apiAuth,
                                                                    appSettings: Constants.AppDependencies.dependencies.appSettings,
                                                                    syncManager: syncManager)
        
        let interactor: AuthorizationInteractorProtocol = AuthorizationInteractor.init(dataManager: dataManager,
                                                                                       authValidation: authValidation,
                                                                                       textFieldDelegate: textFieldDelegate,
                                                                                       authManager: authManager)
        
        var router: AuthorizationRouterProtocol = AuthorizationRouter.init()
        let presenter: AuthorizationPresenterProtocol = AuthorizationPresenter.init(interactor: interactor, router: router)
        let vc = AuthorizationViewController.init(presenter: presenter)
        
        presenter.presenterOutput = vc
        interactor.interactorOutput = presenter
        dataManager.dataManagerOutput = interactor
        router.presenter = vc
        
        return vc
        
    }
    
}
