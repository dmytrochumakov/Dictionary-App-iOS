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
        
        let authManager: MDAuthManagerProtocol = MDAuthManager.init(apiAuth: MDConstants.AppDependencies.dependencies.apiAuth,
                                                                    appSettings: MDConstants.AppDependencies.dependencies.appSettings)
        
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
