//
//  SelectCourseModule.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 23.09.2021.

import UIKit

final class SelectCourseModule {
    
    let sender: Any?
    
    init(sender: Any?) {
        self.sender = sender
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension SelectCourseModule {
    
    var module: UIViewController {
        let dataProvider: SelectCourseDataProviderProtocol = SelectCourseDataProvider.init()
        var dataManager: SelectCourseDataManagerProtocol = SelectCourseDataManager.init(dataProvider: dataProvider)
        
        let interactor: SelectCourseInteractorProtocol = SelectCourseInteractor.init(dataManager: dataManager)
        var router: SelectCourseRouterProtocol = SelectCourseRouter.init()
        let presenter: SelectCoursePresenterProtocol = SelectCoursePresenter.init(interactor: interactor, router: router)
        let vc = SelectCourseViewController.init(presenter: presenter)
        
        presenter.presenterOutput = vc
        interactor.interactorOutput = presenter
        dataManager.dataManagerOutput = interactor
        router.presenter = vc
        
        return vc
    }
    
}
