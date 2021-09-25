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
        
        let jwtManager: MDJWTManagerProtocol = MDJWTManager.init(jwtStorage: MDConstants.AppDependencies.dependencies.jwtStorage,
                                                                 apiJWT: MDConstants.AppDependencies.dependencies.apiJWT)
        
        let memoryStorage: MDCourseMemoryStorageProtocol = MDConstants.AppDependencies.dependencies.courseStorage.memoryStorage
        let dataProvider: CourseListDataProviderProtocol = CourseListDataProvider.init(filteredCourses: .init())
        var dataManager: CourseListDataManagerProtocol = CourseListDataManager.init(memoryStorage: memoryStorage,
                                                                                    dataProvider: dataProvider)
        
        let interactor: CourseListInteractorProtocol = CourseListInteractor.init(courseManager: MDCourseManager.init(userMemoryStorage: MDConstants.AppDependencies.dependencies.userStorage.memoryStorage,
                                                                                                                     jwtManager: jwtManager,
                                                                                                                     apiCourse: MDConstants.AppDependencies.dependencies.apiCourse,
                                                                                                                     courseStorage: MDConstants.AppDependencies.dependencies.courseStorage),
                                                                                 dataManager: dataManager,
                                                                                 fillMemoryService: MDConstants.AppDependencies.dependencies.fillMemoryService,
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
