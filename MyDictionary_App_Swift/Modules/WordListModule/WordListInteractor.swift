//
//  WordListInteractor.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import Foundation

protocol WordListInteractorInputProtocol: CollectionViewDelegatePropertyProtocol,
                                          CollectionViewDataSourcePropertyProtocol {
    
}

protocol WordListInteractorOutputProtocol: AnyObject {
    
}

protocol WordListInteractorProtocol: WordListInteractorInputProtocol,
                                     WordListDataManagerOutputProtocol {
    var interactorOutput: WordListInteractorOutputProtocol? { get set }
}

final class WordListInteractor: WordListInteractorProtocol {
    
    fileprivate let dataManager: WordListDataManagerInputProtocol
    
    internal var collectionViewDelegate: CollectionViewDelegateProtocol
    internal var collectionViewDataSource: CollectionViewDataSourceProtocol
    internal weak var interactorOutput: WordListInteractorOutputProtocol?
    
    init(dataManager: WordListDataManagerInputProtocol,
         collectionViewDelegate: WordListCollectionViewDelegateProtocol,
         collectionViewDataSource: WordListCollectionViewDataSourceProtocol) {
        self.dataManager = dataManager
        self.collectionViewDelegate = collectionViewDelegate
        self.collectionViewDataSource = collectionViewDataSource
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - WordListDataManagerOutputProtocol
extension WordListInteractor {
    
}
