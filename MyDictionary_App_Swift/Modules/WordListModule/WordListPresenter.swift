//
//  WordListPresenter.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import UIKit

protocol WordListPresenterInputProtocol: MDTableViewDelegatePropertyProtocol,
                                         MDTableViewDataSourcePropertyProtocol,
                                         MDViewDidLoadProtocol {
    
}

protocol WordListPresenterOutputProtocol: AnyObject,
                                          MDReloadDataProtocol {
    
}

protocol WordListPresenterProtocol: WordListPresenterInputProtocol,
                                    WordListInteractorOutputProtocol {
    var presenterOutput: WordListPresenterOutputProtocol? { get set }
}

final class WordListPresenter: NSObject,
                               WordListPresenterProtocol {
    
    fileprivate let interactor: WordListInteractorInputProtocol
    fileprivate let router: WordListRouterProtocol
    
    internal weak var presenterOutput: WordListPresenterOutputProtocol?
    
    init(interactor: WordListInteractorInputProtocol,
         router: WordListRouterProtocol) {
        
        self.interactor = interactor
        self.router = router
        
        super.init()
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - WordListInteractorOutputProtocol
extension WordListPresenter {
    
}

// MARK: - WordListPresenterInputProtocol
extension WordListPresenter: WordListPresenterInputProtocol {
    
    var tableViewDelegate: UITableViewDelegate {
        return interactor.tableViewDelegate
    }
    
    var tableViewDataSource: UITableViewDataSource {
        return interactor.tableViewDataSource
    }
    
    func viewDidLoad() {
        interactor.viewDidLoad()
    }
    
}
