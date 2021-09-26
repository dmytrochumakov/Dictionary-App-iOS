//
//  AddCourseModule.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 23.09.2021.

import UIKit

final class AddCourseModule {
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension AddCourseModule {
    
    var module: UIViewController {
        
        let dataProvider: AddCourseDataProviderProtocol = AddCourseDataProvider.init(sections: .init())
        
        var dataManager: AddCourseDataManagerProtocol = AddCourseDataManager.init(memoryStorage: MDConstants.AppDependencies.dependencies.languageStorage.memoryStorage,
                                                                                  dataProvider: dataProvider)
        
        let interactor: AddCourseInteractorProtocol = AddCourseInteractor.init(dataManager: dataManager,
                                                                               collectionViewDelegate: MDAddCourseCollectionViewDelegate.init(dataProvider: dataProvider),
                                                                               collectionViewDataSource: MDAddCourseCollectionViewDataSource.init(dataProvider: dataProvider),
                                                                               searchBarDelegate: MDSearchBarDelegateImplementation.init(),
                                                                               bridge: MDConstants.AppDependencies.dependencies.bridge,
                                                                               courseManager: MDCourseManager.init(jwtManager: MDJWTManager.init(userMemoryStorage: MDConstants.AppDependencies.dependencies.userStorage.memoryStorage,
                                                                                                                                                 jwtStorage: MDConstants.AppDependencies.dependencies.jwtStorage,
                                                                                                                                                 apiJWT: MDConstants.AppDependencies.dependencies.apiJWT),
                                                                                                                   apiCourse: MDConstants.AppDependencies.dependencies.apiCourse,
                                                                                                                   courseStorage: MDConstants.AppDependencies.dependencies.courseStorage))
        
        var router: AddCourseRouterProtocol = AddCourseRouter.init()
        let presenter: AddCoursePresenterProtocol = AddCoursePresenter.init(interactor: interactor, router: router)
        let vc = AddCourseViewController.init(presenter: presenter)
        
        presenter.presenterOutput = vc
        interactor.interactorOutput = presenter
        dataManager.dataManagerOutput = interactor
        router.presenter = vc
        
        return vc
        
    }
    
}
