//
//  WordListModule.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 04.06.2021.
//

import UIKit

struct WordListModuleSender {
    
}

final class WordListModule {
    
    fileprivate let sender: CDCourseEntity
    
    init(sender: CDCourseEntity) {
        self.sender = sender
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension WordListModule {
    
    var module: UIViewController {
        
        // Word List Module Classes
        let wordListDataProvider: WordListDataProviderProcotol = WordListDataProvider.init(course: sender, words: .init())
        var wordListDataManager: WordListDataManagerProtocol = WordListDataManager.init(dataProvider: wordListDataProvider,
                                                                                        coreDataStorage: MDConstants.AppDependencies.dependencies.wordCoreDataStorage,
                                                                                        filterSearchTextService: MDWordFilterSearchTextService.init(operationQueue: MDConstants.AppDependencies.dependencies.operationQueueManager.operationQueue(byName: MDConstants.QueueName.filterSearchTextServiceOperationQueue)!))
        
        let wordListTableViewDelegate: WordListTableViewDelegateProtocol = WordListTableViewDelegate.init(dataProvider: wordListDataProvider)
        let wordListTableViewDataSource: WordListTableViewDataSourceProtocol = WordListTableViewDataSource.init(dataProvider: wordListDataProvider)
        
        let wordListInteractor: WordListInteractorProtocol = WordListInteractor.init(dataManager: wordListDataManager,
                                                                                     tableViewDelegate: wordListTableViewDelegate,
                                                                                     tableViewDataSource: wordListTableViewDataSource,
                                                                                     searchBarDelegate: MDSearchBarDelegateImplementation.init(),
                                                                                     bridge: MDConstants.AppDependencies.dependencies.bridge)
        var wordListRouter: WordListRouterProtocol = WordListRouter.init()
        let wordListPresenter: WordListPresenterProtocol = WordListPresenter.init(interactor: wordListInteractor,
                                                                                  router: wordListRouter)
        let wordListVC = WordListViewController.init(presenter: wordListPresenter)
        
        // Word List Module
        wordListPresenter.presenterOutput = wordListVC
        wordListInteractor.interactorOutput = wordListPresenter
        wordListDataManager.dataManagerOutput = wordListInteractor
        wordListRouter.wordListViewController = wordListVC
        //
        return wordListVC
        
    }
    
}
