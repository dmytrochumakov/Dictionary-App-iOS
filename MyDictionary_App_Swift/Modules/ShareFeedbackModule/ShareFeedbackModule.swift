//
//  ShareFeedbackModule.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 22.09.2021.

import UIKit

final class ShareFeedbackModule {
    
    let sender: Any?
    
    init(sender: Any?) {
        self.sender = sender
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension ShareFeedbackModule {
    
    var module: UIViewController {
        let dataProvider: ShareFeedbackDataProviderProtocol = ShareFeedbackDataProvider.init()
        var dataManager: ShareFeedbackDataManagerProtocol = ShareFeedbackDataManager.init(dataProvider: dataProvider)
        
        let interactor: ShareFeedbackInteractorProtocol = ShareFeedbackInteractor.init(dataManager: dataManager)
        var router: ShareFeedbackRouterProtocol = ShareFeedbackRouter.init()
        let presenter: ShareFeedbackPresenterProtocol = ShareFeedbackPresenter.init(interactor: interactor, router: router)
        let vc = ShareFeedbackViewController.init(presenter: presenter)
        
        presenter.presenterOutput = vc
        interactor.interactorOutput = presenter
        dataManager.dataManagerOutput = interactor
        router.presenter = vc
        
        return vc
    }
    
}
