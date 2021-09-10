//
//  ChoiceAuthenticationOrRegistrationModule.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 10.09.2021.

import UIKit

final class ChoiceAuthenticationOrRegistrationModule {
    
    let sender: Any?
    
    init(sender: Any?) {
        self.sender = sender
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension ChoiceAuthenticationOrRegistrationModule {
    
    var module: UIViewController {
        let dataProvider: ChoiceAuthenticationOrRegistrationDataProviderProtocol = ChoiceAuthenticationOrRegistrationDataProvider.init()
        var dataManager: ChoiceAuthenticationOrRegistrationDataManagerProtocol = ChoiceAuthenticationOrRegistrationDataManager.init(dataProvider: dataProvider)
        
        let interactor: ChoiceAuthenticationOrRegistrationInteractorProtocol = ChoiceAuthenticationOrRegistrationInteractor.init(dataManager: dataManager)
        var router: ChoiceAuthenticationOrRegistrationRouterProtocol = ChoiceAuthenticationOrRegistrationRouter.init()
        let presenter: ChoiceAuthenticationOrRegistrationPresenterProtocol = ChoiceAuthenticationOrRegistrationPresenter.init(interactor: interactor, router: router)
        let vc = ChoiceAuthenticationOrRegistrationViewController.init(presenter: presenter)
        
        presenter.presenterOutput = vc
        interactor.interactorOutput = presenter
        dataManager.dataManagerOutput = interactor
        router.presenter = vc
        
        return vc
    }
    
}
