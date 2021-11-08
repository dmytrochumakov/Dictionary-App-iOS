//
//  CourseListModule.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 11.08.2021.

import UIKit

final class CourseListModule {       
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension CourseListModule {
    
    var module: UIViewController {
                        
        let dataProvider: CourseListDataProviderProtocol = CourseListDataProvider.init(filteredCourses: .init())
        
        var dataManager: CourseListDataManagerProtocol = CourseListDataManager.init(coreDataStorage: MDConstants.AppDependencies.dependencies.courseCoreDataStorage,
                                                                                    dataProvider: dataProvider,
                                                                                    filterSearchTextService: MDFilterSearchTextService<CDCourseEntity>.init(operationQueue: MDConstants.AppDependencies.dependencies.operationQueueManager.operationQueue(byName: MDConstants.QueueName.filterSearchTextServiceOperationQueue)!))
        
        let interactor: CourseListInteractorProtocol = CourseListInteractor.init(dataManager: dataManager,
                                                                                 collectionViewDelegate: CourseListTableViewDelegate.init(dataProvider: dataProvider),
                                                                                 collectionViewDataSource: CourseListTableViewDataSource.init(dataProvider: dataProvider),
                                                                                 searchBarDelegate: MDSearchBarDelegateImplementation.init(),
                                                                                 bridge: MDConstants.AppDependencies.dependencies.bridge)
        
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
