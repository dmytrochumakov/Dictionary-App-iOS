//
//  AddCourseInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 23.09.2021.

import UIKit

protocol AddCourseInteractorInputProtocol {
    
    var collectionViewDelegate: MDAddCourseCollectionViewDelegateProtocol { get }
    var collectionViewDataSource: MDAddCourseCollectionViewDataSourceProtocol { get }
    var searchBarDelegate: MDSearchBarDelegateImplementationProtocol { get }
    
    func viewDidLoad()
    
}

protocol AddCourseInteractorOutputProtocol: AnyObject,
                                            MDShowErrorProtocol,
                                            MDReloadDataProtocol,
                                            MDHideKeyboardProtocol {
    
}

protocol AddCourseInteractorProtocol: AddCourseInteractorInputProtocol,
                                      AddCourseDataManagerOutputProtocol {
    var interactorOutput: AddCourseInteractorOutputProtocol? { get set }
}

final class AddCourseInteractor: NSObject,
                                 AddCourseInteractorProtocol {
    
    fileprivate let dataManager: AddCourseDataManagerInputProtocol
    internal var collectionViewDelegate: MDAddCourseCollectionViewDelegateProtocol
    internal var collectionViewDataSource: MDAddCourseCollectionViewDataSourceProtocol
    internal var searchBarDelegate: MDSearchBarDelegateImplementationProtocol
    internal weak var interactorOutput: AddCourseInteractorOutputProtocol?
    
    init(dataManager: AddCourseDataManagerInputProtocol,
         collectionViewDelegate: MDAddCourseCollectionViewDelegateProtocol,
         collectionViewDataSource: MDAddCourseCollectionViewDataSourceProtocol,
         searchBarDelegate: MDSearchBarDelegateImplementationProtocol) {
        
        self.collectionViewDelegate = collectionViewDelegate
        self.collectionViewDataSource = collectionViewDataSource
        self.dataManager = dataManager
        self.searchBarDelegate = searchBarDelegate
        
        super.init()
        subscribe()
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - AddCourseDataManagerOutputProtocol
extension AddCourseInteractor {
    
    func loadAndPassLanguagesArrayToDataProviderResult(_ result: MDOperationResultWithoutCompletion<Void>) {
        checkResultAndExecuteReloadDataOrShowError(result)
    }
    
    func filteredLanguagesResult(_ result: MDOperationResultWithoutCompletion<Void>) {
        checkResultAndExecuteReloadDataOrShowError(result)
    }
    
    func clearLanguageFilterResult(_ result: MDOperationResultWithoutCompletion<Void>) {
        checkResultAndExecuteReloadDataOrShowError(result)
    }
    
}

// MARK: - AddCourseInteractorInputProtocol
extension AddCourseInteractor {
    
    func viewDidLoad() {
        dataManager.loadAndPassLanguagesArrayToDataProvider()
    }
    
}

// MARK: - Subscribe
fileprivate extension AddCourseInteractor {
    
    func subscribe() {
        //
        searchBarCancelButtonAction_Subscribe()
        //
        searchBarSearchButtonAction_Subscribe()
        //
        searchBarTextDidChangeAction_Subscribe()
        //
        searchBarShouldClearAction_Subscribe()
        //
    }
    
    func searchBarCancelButtonAction_Subscribe() {
        
        searchBarDelegate.searchBarCancelButtonAction = { [weak self] in
            self?.interactorOutput?.hideKeyboard()
        }
        
    }
    
    func searchBarSearchButtonAction_Subscribe() {
        
        searchBarDelegate.searchBarSearchButtonAction = { [weak self] in
            self?.interactorOutput?.hideKeyboard()
        }
        
    }
    
    func searchBarTextDidChangeAction_Subscribe() {
        
        searchBarDelegate.searchBarTextDidChangeAction = { [weak self] (searchText) in
            self?.dataManager.filterLanguages(searchText)
        }
        
    }
    
    func searchBarShouldClearAction_Subscribe() {
        
        searchBarDelegate.searchBarShouldClearAction = { [weak self] in
            self?.dataManager.clearLanguageFilter()
        }
        
    }
    
}

// MARK: - Private Methods
fileprivate extension AddCourseInteractor {
    
    func checkResultAndExecuteReloadDataOrShowError(_ result: MDOperationResultWithoutCompletion<Void>) {
        switch result {
        case .success:
            self.interactorOutput?.reloadData()
        case .failure(let error):
            self.interactorOutput?.showError(error)
        }
        
    }
    
}
