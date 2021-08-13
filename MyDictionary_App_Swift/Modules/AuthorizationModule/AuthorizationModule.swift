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
        
        let interactor: AuthorizationInteractorProtocol = AuthorizationInteractor.init(dataManager: dataManager,
                                                                                       authValidation: authValidation,
                                                                                       textFieldDelegate: textFieldDelegate)
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
