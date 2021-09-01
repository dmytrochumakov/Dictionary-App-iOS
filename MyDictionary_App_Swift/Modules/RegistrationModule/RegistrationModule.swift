//
//  RegistrationModule.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 14.08.2021.

import UIKit

final class RegistrationModule {
    
    let sender: Any?
    
    init(sender: Any?) {
        self.sender = sender
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension RegistrationModule {
    
    var module: UIViewController {
        
        let dataProvider: RegistrationDataProviderProtocol = RegistrationDataProvider.init()
        var dataManager: RegistrationDataManagerProtocol = RegistrationDataManager.init(dataProvider: dataProvider)
        
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
        
        let interactor: RegistrationInteractorProtocol = RegistrationInteractor.init(dataManager: dataManager,
                                                                                     authValidation: authValidation,
                                                                                     textFieldDelegate: textFieldDelegate,
                                                                                     apiManager: authManager)
        
        var router: RegistrationRouterProtocol = RegistrationRouter.init()
        let presenter: RegistrationPresenterProtocol = RegistrationPresenter.init(interactor: interactor, router: router)
        let vc = RegistrationViewController.init(presenter: presenter)
        
        presenter.presenterOutput = vc
        interactor.interactorOutput = presenter
        dataManager.dataManagerOutput = interactor
        router.presenter = vc
        
        return vc
        
    }
    
}
