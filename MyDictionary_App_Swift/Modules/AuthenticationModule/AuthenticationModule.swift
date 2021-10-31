//
//  AuthenticationModule.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 12.08.2021.

import UIKit

final class AuthenticationModule {
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension AuthenticationModule {
    
    var module: UIViewController {
        
        let dataProvider: AuthenticationDataProviderProtocol = AuthenticationDataProvider.init()
        var dataManager: AuthenticationDataManagerProtocol = AuthenticationDataManager.init(dataProvider: dataProvider)
        
        let textFieldDelegate: AuthTextFieldDelegateProtocol = AuthTextFieldDelegate.init()
        
        let validationTypes: [AuthValidationType] = [.nickname, .password]
        let authValidation: AuthValidationProtocol = AuthValidation.init(dataProvider: dataProvider,
                                                                         validationTypes: validationTypes)
        
        
        let authManager: MDAuthManagerProtocol = MDAuthManager.init(apiAuth: MDConstants.AppDependencies.dependencies.apiAuth,
                                                                    appSettings: MDConstants.AppDependencies.dependencies.appSettings)
        
        let interactor: AuthenticationInteractorProtocol = AuthenticationInteractor.init(dataManager: dataManager,
                                                                                         authValidation: authValidation,
                                                                                         textFieldDelegate: textFieldDelegate,
                                                                                         authManager: authManager)
        
        var router: AuthenticationRouterProtocol = AuthenticationRouter.init()
        let presenter: AuthenticationPresenterProtocol = AuthenticationPresenter.init(interactor: interactor, router: router)
        let vc = AuthenticationViewController.init(presenter: presenter)
        
        presenter.presenterOutput = vc
        interactor.interactorOutput = presenter
        dataManager.dataManagerOutput = interactor
        router.presenter = vc
        
        return vc
        
    }
    
}
