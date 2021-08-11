//
//  CourseListModule.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 11.08.2021.

import UIKit

final class CourseListModule {
    
    let sender: Any?
    
    init(sender: Any?) {
        self.sender = sender
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension CourseListModule {
    
    var module: UIViewController {
        let dataProvider: CourseListDataProviderProtocol = CourseListDataProvider.init()
        var dataManager: CourseListDataManagerProtocol = CourseListDataManager.init(dataProvider: dataProvider)
        
        let tableViewDelegate: CourseListTableViewDelegateProtocol = CourseListTableViewDelegate.init(dataProvider: dataProvider)
        let tableViewDataSource: CourseListTableViewDataSourceProtocol = CourseListTableViewDataSource.init(dataProvider: dataProvider)
        
        let interactor: CourseListInteractorProtocol = CourseListInteractor.init(dataManager: dataManager,
                                                                                 tableViewDelegate: tableViewDelegate,
                                                                                 tableViewDataSource: tableViewDataSource)
        
        var router: CourseListRouterProtocol = CourseListRouter.init()
        let presenter: CourseListPresenterProtocol = CourseListPresenter.init(interactor: interactor, router: router)
        let vc = CourseListViewController.init(presenter: presenter)
        
        presenter.presenterOutput = vc
        interactor.interactorOutput = presenter
        dataManager.dataManagerOutput = interactor
        router.presenter = vc
        
        return vc
    }
    
}
