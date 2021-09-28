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
    
    fileprivate let sender: CourseResponse
    
    init(sender: CourseResponse) {
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
                                                                                        memoryStorage: MDConstants.AppDependencies.dependencies.wordStorage.memoryStorage)
        let wordListTableViewDelegate: WordListTableViewDelegateProtocol = WordListTableViewDelegate.init(dataProvider: wordListDataProvider)
        let wordListTableViewDataSource: WordListTableViewDataSourceProtocol = WordListTableViewDataSource.init(dataProvider: wordListDataProvider)
        
        let wordListInteractor: WordListInteractorProtocol = WordListInteractor.init(dataManager: wordListDataManager,
                                                                                     tableViewDelegate: wordListTableViewDelegate,
                                                                                     tableViewDataSource: wordListTableViewDataSource,
                                                                                     searchBarDelegate: MDSearchBarDelegateImplementation.init(),
                                                                                     wordManager: MDWordManager.init(jwtManager: MDJWTManager.init(userMemoryStorage: MDConstants.AppDependencies.dependencies.userStorage.memoryStorage,
                                                                                                                                                   jwtStorage: MDConstants.AppDependencies.dependencies.jwtStorage,
                                                                                                                                                   apiJWT: MDConstants.AppDependencies.dependencies.apiJWT),
                                                                                                                     apiWord: MDConstants.AppDependencies.dependencies.apiWord,
                                                                                                                     wordStorage: MDConstants.AppDependencies.dependencies.wordStorage),
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
