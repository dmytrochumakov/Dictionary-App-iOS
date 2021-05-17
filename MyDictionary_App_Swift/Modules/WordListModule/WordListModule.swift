//
//  WordListModule.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import UIKit

final class WordListModule {
    
    let sender: Any?
    
    init(sender: Any?) {
        self.sender = sender
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension WordListModule {
    
    var module: UIViewController {
        let dataProvider: WordListDataProviderProcotol = WordListDataProvider.init()
        var dataManager: WordListDataManagerProtocol = WordListDataManager.init(dataProvider: dataProvider)
        let collectionViewDelegate: WordListCollectionViewDelegateProtocol = WordListCollectionViewDelegate.init(dataProvider: dataProvider)
        
        let interactor: WordListInteractorProtocol = WordListInteractor.init(dataManager: dataManager,
                                                                             collectionViewDelegate: collectionViewDelegate)
        var router: WordListRouterProtocol = WordListRouter.init()
        let presenter: WordListPresenterProtocol = WordListPresenter.init(interactor: interactor, router: router)
        let vc = WordListViewController.init(presenter: presenter)
        
        presenter.presenterOutput = vc
        interactor.interactorOutput = presenter
        dataManager.dataManagerOutput = interactor
        router.presenter = vc
        
        return vc 
    }
    
}
