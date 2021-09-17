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
        
        let fillMemoryService: MDFillMemoryServiceProtocol = MDConstants.AppDependencies.dependencies.fillMemoryService
        let memoryStorage: MDCourseMemoryStorageProtocol = MDConstants.AppDependencies.dependencies.courseStorage.memoryStorage
        let dataProvider: CourseListDataProviderProtocol = CourseListDataProvider.init(courses: .init())
        var dataManager: CourseListDataManagerProtocol = CourseListDataManager.init(memoryStorage: memoryStorage,
                                                                                    dataProvider: dataProvider)
        
        let collectionViewDelegate: CourseListCollectionViewDelegateProtocol = CourseListCollectionViewDelegate.init(dataProvider: dataProvider)
        let collectionViewDataSource: CourseListCollectionViewDataSourceProtocol = CourseListCollectionViewDataSource.init(dataProvider: dataProvider)
        
        let interactor: CourseListInteractorProtocol = CourseListInteractor.init(dataManager: dataManager,
                                                                                 fillMemoryService: fillMemoryService,
                                                                                 collectionViewDelegate: collectionViewDelegate,
                                                                                 collectionViewDataSource: collectionViewDataSource)
        
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
