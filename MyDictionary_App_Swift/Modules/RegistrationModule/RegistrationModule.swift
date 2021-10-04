//
//  RegistrationModule.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 14.08.2021.

import UIKit

final class RegistrationModule {
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension RegistrationModule {
    
    var module: UIViewController {
        
        let dataProvider: RegistrationDataProviderProtocol = RegistrationDataProvider.init()
        var dataManager: RegistrationDataManagerProtocol = RegistrationDataManager.init(dataProvider: dataProvider)
        
        let textFieldDelegate: RegisterTextFieldDelegateProtocol = RegisterTextFieldDelegate.init()
        
        let validationTypes: [RegisterValidationType] = [.nickname, .password, .confirmPassword]
        let registerValidation: RegisterValidationProtocol = RegisterValidation.init(dataProvider: dataProvider,
                                                                                     validationTypes: validationTypes)
        
        let sync: MDSyncProtocol = MDSync.init(apiJWT: MDConstants.AppDependencies.dependencies.apiJWT,
                                               jwtStorage: MDConstants.AppDependencies.dependencies.jwtStorage,
                                               apiUser: MDConstants.AppDependencies.dependencies.apiUser,
                                               userStorage: MDConstants.AppDependencies.dependencies.userStorage,
                                               apiLanguage: MDConstants.AppDependencies.dependencies.apiLanguage,
                                               languageStorage: MDConstants.AppDependencies.dependencies.languageStorage,
                                               apiCourse: MDConstants.AppDependencies.dependencies.apiCourse,
                                               courseStorage: MDConstants.AppDependencies.dependencies.courseStorage,
                                               apiWord: MDConstants.AppDependencies.dependencies.apiWord,
                                               wordStorage: MDConstants.AppDependencies.dependencies.wordStorage,
                                               storageCleanupService: MDStorageCleanupService.init(jwtStorage: MDConstants.AppDependencies.dependencies.jwtStorage,
                                                                                                   userStorage: MDConstants.AppDependencies.dependencies.userStorage,
                                                                                                   languageStorage: MDConstants.AppDependencies.dependencies.languageStorage,
                                                                                                   courseStorage: MDConstants.AppDependencies.dependencies.courseStorage,
                                                                                                   wordStorage: MDConstants.AppDependencies.dependencies.wordStorage))
        
        let syncManager: MDSyncManagerProtocol = MDSyncManager.init(sync: sync)
        let authManager: MDAuthManagerProtocol = MDAuthManager.init(apiAuth: MDConstants.AppDependencies.dependencies.apiAuth,
                                                                    appSettings: MDConstants.AppDependencies.dependencies.appSettings,
                                                                    syncManager: syncManager)
        
        let interactor: RegistrationInteractorProtocol = RegistrationInteractor.init(dataManager: dataManager,
                                                                                     registerValidation: registerValidation,
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
