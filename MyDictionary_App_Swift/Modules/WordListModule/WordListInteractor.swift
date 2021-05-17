//
//  WordListInteractor.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import Foundation

protocol WordListInteractorInputProtocol: CollectionViewDelegatePropertyProtocol {
    
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
    internal weak var interactorOutput: WordListInteractorOutputProtocol?
    
    init(dataManager: WordListDataManagerInputProtocol,
         collectionViewDelegate: WordListCollectionViewDelegateProtocol) {
        self.dataManager = dataManager
        self.collectionViewDelegate = collectionViewDelegate
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - WordListDataManagerOutputProtocol
extension WordListInteractor {
    
}
