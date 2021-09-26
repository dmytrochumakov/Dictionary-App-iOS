//
//  WordListInteractor.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import Foundation

protocol WordListInteractorInputProtocol: MDViewDidLoadProtocol {
    var tableViewDelegate: WordListTableViewDelegateProtocol { get }
    var tableViewDataSource: WordListTableViewDataSourceProtocol { get }
}

protocol WordListInteractorOutputProtocol: AnyObject {
    
}

protocol WordListInteractorProtocol: WordListInteractorInputProtocol,
                                     WordListDataManagerOutputProtocol {
    var interactorOutput: WordListInteractorOutputProtocol? { get set }
}

final class WordListInteractor: NSObject,
                                WordListInteractorProtocol {
    
    fileprivate let dataManager: WordListDataManagerInputProtocol
    
    internal var tableViewDelegate: WordListTableViewDelegateProtocol
    internal var tableViewDataSource: WordListTableViewDataSourceProtocol
    
    internal weak var interactorOutput: WordListInteractorOutputProtocol?
    
    init(dataManager: WordListDataManagerInputProtocol,
         tableViewDelegate: WordListTableViewDelegateProtocol,
         tableViewDataSource: WordListTableViewDataSourceProtocol) {
        
        self.dataManager = dataManager
        self.tableViewDelegate = tableViewDelegate
        self.tableViewDataSource = tableViewDataSource
        
        super.init()
        subscribe()
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - WordListDataManagerOutputProtocol
extension WordListInteractor {
    
}

// MARK: - WordListInteractorInputProtocol
extension WordListInteractor {
 
    func viewDidLoad() {
        
    }
    
}

// MARK: - Subscribe
fileprivate extension WordListInteractor {
    
    func subscribe() {
        
    }
    
}
