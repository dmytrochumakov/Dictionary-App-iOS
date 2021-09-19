//
//  CourseListInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 11.08.2021.

import UIKit

protocol CourseListInteractorInputProtocol {
    var tableViewDelegate: CourseListTableViewDelegateProtocol { get }
    var tableViewDataSource: CourseListTableViewDataSourceProtocol { get }
    var searchBarDelegate: MDCourseListSearchBarDelegateProtocol { get }
}

protocol CourseListInteractorOutputProtocol: AnyObject,
                                             AppearanceHasBeenUpdatedProtocol {
    
    func showError(_ error: Error)
    func reloadData()
    func hideKeyboard()
    
}

protocol CourseListInteractorProtocol: CourseListInteractorInputProtocol,
                                       CourseListDataManagerOutputProtocol {
    var interactorOutput: CourseListInteractorOutputProtocol? { get set }
}

final class CourseListInteractor: NSObject, CourseListInteractorProtocol {
    
    fileprivate let dataManager: CourseListDataManagerInputProtocol
    fileprivate let fillMemoryService: MDFillMemoryServiceProtocol
    
    internal var tableViewDelegate: CourseListTableViewDelegateProtocol
    internal var tableViewDataSource: CourseListTableViewDataSourceProtocol
    internal var searchBarDelegate: MDCourseListSearchBarDelegateProtocol
    
    internal weak var interactorOutput: CourseListInteractorOutputProtocol?
    
    init(dataManager: CourseListDataManagerInputProtocol,
         fillMemoryService: MDFillMemoryServiceProtocol,
         collectionViewDelegate: CourseListTableViewDelegateProtocol,
         collectionViewDataSource: CourseListTableViewDataSourceProtocol,
         searchBarDelegate: MDCourseListSearchBarDelegateProtocol) {
        
        self.dataManager = dataManager
        self.fillMemoryService = fillMemoryService
        self.tableViewDelegate = collectionViewDelegate
        self.tableViewDataSource = collectionViewDataSource
        self.searchBarDelegate = searchBarDelegate
        
        super.init()
        subscribe()        
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
        unsubscribe()
    }
    
}

// MARK: - CourseListDataManagerOutputProtocol
extension CourseListInteractor {
    
}

// MARK: - Subscribe
fileprivate extension CourseListInteractor {
    
    func subscribe() {
        didChangeAppearanceObservable_Subscribe()
        didChangeMemoryIsFilledObservable_Subscribe()
        //
        readAndAddCoursesToDataProvider()
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
    
    func didChangeAppearanceObservable_Subscribe() {
        Appearance
            .current
            .didChangeAppearanceObservable
            .addObserver(self) { [weak self] (value) in
                self?.interactorOutput?.appearanceHasBeenUpdated(value)
            }
    }
    
    func didChangeMemoryIsFilledObservable_Subscribe() {
        fillMemoryService
            .didChangeMemoryIsFilledResultObservable
            .addObserver(self) { [weak self] result in
                
                switch result {
                
                case .success:
                    self?.readAndAddCoursesToDataProvider()
                    break
                    
                case .failure(let error):
                    self?.interactorOutput?.showError(error)
                    break
                
                case .none:
                    break
                    
                }
                
            }
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
            self?.dataManager.searchBarTextDidChangeAction(searchText) { [weak self] result in
                
                switch result {
                case .success:
                    self?.interactorOutput?.reloadData()
                case .failure(let error):
                    self?.interactorOutput?.showError(error)
                }
                
            }
        }
        
    }
    
    func searchBarShouldClearAction_Subscribe() {
        
        searchBarDelegate.searchBarShouldClearAction = { [weak self] in
            self?.dataManager.searchBarShouldClearAction() { [weak self] (result) in
                
                switch result {
                case .success:
                    self?.interactorOutput?.reloadData()
                case .failure(let error):
                    self?.interactorOutput?.showError(error)
                }
                
            }
        }
        
    }
    
}

// MARK: - Unsubscribe
fileprivate extension CourseListInteractor {
    
    func unsubscribe() {
        didChangeAppearanceObservable_Unsubscribe()
        didChangeMemoryIsFilledObservable_Unsubscribe()
    }
    
    func didChangeAppearanceObservable_Unsubscribe() {
        Appearance
            .current
            .didChangeAppearanceObservable
            .removeObserver(self)
    }
    
    
    func didChangeMemoryIsFilledObservable_Unsubscribe() {
        fillMemoryService
            .didChangeMemoryIsFilledResultObservable
            .removeObserver(self)
    }
    
}

// MARK: -
fileprivate extension CourseListInteractor {
    
    func readAndAddCoursesToDataProvider() {
        
        dataManager.readAndAddCoursesToDataProvider { [weak self] result in
            
            switch result {
            
            case .success:
                self?.interactorOutput?.reloadData()
                break
                
            case .failure(let error):
                self?.interactorOutput?.showError(error)
                break
            }
            
        }
        
    }
    
}
