//
//  WordListPresenter.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import UIKit

protocol WordListPresenterInputProtocol: MDTableViewDelegatePropertyProtocol,
                                         MDTableViewDataSourcePropertyProtocol,
                                         MDViewDidLoadProtocol,
                                         MDSearchBarDelegatePropertyProtocol {
    
    func addNewWordButtonClicked()
    
}

protocol WordListPresenterOutputProtocol: AnyObject,
                                          MDReloadDataProtocol,
                                          MDHideKeyboardProtocol,
                                          MDShowErrorProtocol,
                                          MDShowHideProgressHUD,
                                          MDDeleteRowProtocol,
                                          MDInsertRowProtocol,
                                          MDUpdateRowProtocol {
    
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
extension WordListPresenter: WordListInteractorOutputProtocol {
    
    func hideKeyboard() {
        presenterOutput?.hideKeyboard()
    }
    
    func reloadData() {
        presenterOutput?.reloadData()
    }
    
    func showError(_ error: Error) {
        presenterOutput?.showError(error)
    }
    
    func deleteRow(atIndexPath indexPath: IndexPath) {
        presenterOutput?.deleteRow(atIndexPath: indexPath)
    }
    
    func insertRow(atIndexPath indexPath: IndexPath) {
        presenterOutput?.insertRow(atIndexPath: indexPath)
    }
    
    func showProgressHUD() {
        presenterOutput?.showProgressHUD()
    }
    
    func hideProgressHUD() {
        presenterOutput?.hideProgressHUD()
    }
    
    func showAddWord(withCourse course: CourseResponse) {
        router.showAddWord(withCourse: course)
    }
    
    func showEditWord(withWord word: MDWordModel) {
        router.showEditWord(withWord: word)
    }
    
    func updateRow(atIndexPath indexPath: IndexPath) {
        presenterOutput?.updateRow(atIndexPath: indexPath)
    }
    
}

// MARK: - WordListPresenterInputProtocol
extension WordListPresenter: WordListPresenterInputProtocol {
    
    var tableViewDelegate: UITableViewDelegate {
        return interactor.tableViewDelegate
    }
    
    var tableViewDataSource: UITableViewDataSource {
        return interactor.tableViewDataSource
    }
    
    var searchBarDelegate: MDSearchBarDelegate {
        return interactor.searchBarDelegate
    }
    
    func viewDidLoad() {
        interactor.viewDidLoad()
    }
    
    func addNewWordButtonClicked() {
        interactor.addNewWordButtonClicked()
    }
    
}
