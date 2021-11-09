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
        
        var dataManager: AddCourseDataManagerProtocol = AddCourseDataManager.init(dataProvider: dataProvider,
                                                                                  languageMemoryStorage: MDConstants.AppDependencies.dependencies.languageMemoryStorage,
                                                                                  filterSearchTextService: MDFilterSearchTextService.init(operationQueue: MDConstants.AppDependencies.dependencies.operationQueueManager.operationQueue(byName: MDConstants.QueueName.filterSearchTextServiceOperationQueue)!))
        
        let interactor: AddCourseInteractorProtocol = AddCourseInteractor.init(dataManager: dataManager,
                                                                               collectionViewDelegate: MDAddCourseCollectionViewDelegate.init(dataProvider: dataProvider),
                                                                               collectionViewDataSource: MDAddCourseCollectionViewDataSource.init(dataProvider: dataProvider),
                                                                               searchBarDelegate: MDSearchBarDelegateImplementation.init(),
                                                                               bridge: MDConstants.AppDependencies.dependencies.bridge,
                                                                               courseCoreDataStorage: MDCourseCoreDataStorage.init(operationQueue: MDConstants.AppDependencies.dependencies.operationQueueManager.operationQueue(byName: MDConstants.QueueName.courseCoreDataStorageOperationQueue)!,
                                                                                                                                   managedObjectContext: MDConstants.AppDependencies.dependencies.coreDataStack.privateContext,
                                                                                                                                   coreDataStack: MDConstants.AppDependencies.dependencies.coreDataStack))
        
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
