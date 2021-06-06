//
//  WordListInteractor.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import Foundation

protocol WordListInteractorInputProtocol {
    var collectionViewDelegate: WordListCollectionViewDelegateProtocol { get }
    var collectionViewDataSource: WordListCollectionViewDataSourceProtocol { get }
}

protocol WordListInteractorOutputProtocol: AnyObject,
                                           AppearanceHasBeenUpdatedProtocol {
    
}

protocol WordListInteractorProtocol: WordListInteractorInputProtocol,
                                     WordListDataManagerOutputProtocol {
    var interactorOutput: WordListInteractorOutputProtocol? { get set }
}

final class WordListInteractor: NSObject,
                                WordListInteractorProtocol {
    
    fileprivate let dataManager: WordListDataManagerInputProtocol
    
    internal var collectionViewDelegate: WordListCollectionViewDelegateProtocol
    internal var collectionViewDataSource: WordListCollectionViewDataSourceProtocol
    internal weak var interactorOutput: WordListInteractorOutputProtocol?
    
    init(dataManager: WordListDataManagerInputProtocol,
         collectionViewDelegate: WordListCollectionViewDelegateProtocol,
         collectionViewDataSource: WordListCollectionViewDataSourceProtocol) {
        
        self.dataManager = dataManager
        self.collectionViewDelegate = collectionViewDelegate
        self.collectionViewDataSource = collectionViewDataSource
        
        super.init()
        subscribe()
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
        unsubscribe()
    }
    
}

// MARK: - WordListDataManagerOutputProtocol
extension WordListInteractor {
    
}

// MARK: - Subscribe
fileprivate extension WordListInteractor {
    
    func subscribe() {
        didChangeAppearanceObservableSubscribe()
    }
    
    func didChangeAppearanceObservableSubscribe() {
        Appearance
            .current
            .didChangeAppearanceObservable
            .addObserver(self) { [weak self] (value) in
                self?.interactorOutput?.appearanceHasBeenUpdated(value)
                self?.dataManager.appearanceHasBeenUpdated(value)
            }
    }
    
}

// MARK: - Unsubscribe
fileprivate extension WordListInteractor {
    
    func unsubscribe() {
        Appearance
            .current
            .didChangeAppearanceObservable
            .removeObserver(self)
    }
    
}
