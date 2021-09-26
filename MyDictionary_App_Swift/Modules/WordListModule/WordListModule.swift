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
    
}

extension WordListModule {
    
    var module: UIViewController {
        // Word List Module Classes
        let wordListDataProvider: WordListDataProviderProcotol = WordListDataProvider.init()
        var wordListDataManager: WordListDataManagerProtocol = WordListDataManager.init(dataProvider: wordListDataProvider)
        let wordListCollectionViewDelegate: WordListCollectionViewDelegateProtocol = WordListCollectionViewDelegate.init(dataProvider: wordListDataProvider)
        let wordListCollectionViewDataSource: WordListCollectionViewDataSourceProtocol = WordListCollectionViewDataSource.init(dataProvider: wordListDataProvider)
        
        let wordListInteractor: WordListInteractorProtocol = WordListInteractor.init(dataManager: wordListDataManager,
                                                                                     collectionViewDelegate: wordListCollectionViewDelegate,
                                                                                     collectionViewDataSource: wordListCollectionViewDataSource)
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
