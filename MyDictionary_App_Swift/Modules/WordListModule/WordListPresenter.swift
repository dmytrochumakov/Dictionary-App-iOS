//
//  WordListPresenter.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import Foundation

protocol WordListPresenterInputProtocol {
    
}

protocol WordListPresenterOutputProtocol: AnyObject, ReloadDataProtocol {
    
}

protocol WordListPresenterProtocol: WordListPresenterInputProtocol,
                                    WordListInteractorOutputProtocol {
    var presenterOutput: WordListPresenterOutputProtocol? { get set }
}

final class WordListPresenter: WordListPresenterProtocol {
    
    fileprivate let interactor: WordListInteractorInputProtocol
    fileprivate let router: WordListRouterProtocol
    
    weak var presenterOutput: WordListPresenterOutputProtocol?
    
    init(interactor: WordListInteractorInputProtocol,
         router: WordListRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - WordListInteractorOutputProtocol
extension WordListPresenter {
    
}
