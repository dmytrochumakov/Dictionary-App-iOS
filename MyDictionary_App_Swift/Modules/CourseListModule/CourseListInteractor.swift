//
//  CourseListInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 11.08.2021.

import UIKit

protocol CourseListInteractorInputProtocol {
    
    var tableViewDelegate: CourseListTableViewDelegateProtocol { get }
    var tableViewDataSource: CourseListTableViewDataSourceProtocol { get }
    var searchBarDelegate: MDSearchBarDelegateImplementationProtocol { get }
    
    func deleteCourse(atIndexPath indexPath: IndexPath)
    
}

protocol CourseListInteractorOutputProtocol: AnyObject,
                                             AppearanceHasBeenUpdatedProtocol,
                                             MDShowHideProgressHUD,
                                             MDHideKeyboardProtocol {
    
    func showError(_ error: Error)
    func reloadData()
    func deleteCourseButtonClicked(_ cell: MDCourseListCell)
    func deleteRow(atIndexPath indexPath: IndexPath)
    
}

protocol CourseListInteractorProtocol: CourseListInteractorInputProtocol,
                                       CourseListDataManagerOutputProtocol {
    var interactorOutput: CourseListInteractorOutputProtocol? { get set }
}    

final class CourseListInteractor: NSObject, CourseListInteractorProtocol {
    
    fileprivate let courseManager: MDCourseManagerProtocol
    fileprivate let dataManager: CourseListDataManagerInputProtocol
    fileprivate let fillMemoryService: MDFillMemoryServiceProtocol
    
    internal var tableViewDelegate: CourseListTableViewDelegateProtocol
    internal var tableViewDataSource: CourseListTableViewDataSourceProtocol
    internal var searchBarDelegate: MDSearchBarDelegateImplementationProtocol
    
    internal weak var interactorOutput: CourseListInteractorOutputProtocol?
    
    init(courseManager: MDCourseManagerProtocol,
         dataManager: CourseListDataManagerInputProtocol,
         fillMemoryService: MDFillMemoryServiceProtocol,
         collectionViewDelegate: CourseListTableViewDelegateProtocol,
         collectionViewDataSource: CourseListTableViewDataSourceProtocol,
         searchBarDelegate: MDSearchBarDelegateImplementationProtocol) {
        
        self.courseManager = courseManager
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
    
    func readAndAddCoursesToDataProviderResult(_ result: MDOperationResultWithoutCompletion<Void>) {
        checkResultAndExecuteReloadDataOrShowError(result)
    }
    
    func filteredCoursesResult(_ result: MDOperationResultWithoutCompletion<Void>) {
        checkResultAndExecuteReloadDataOrShowError(result)
    }
    
    func clearCourseFilterResult(_ result: MDOperationResultWithoutCompletion<Void>) {
        checkResultAndExecuteReloadDataOrShowError(result)
    }
    
}

// MARK: - CourseListInteractorInputProtocol
extension CourseListInteractor {
    
    func deleteCourse(atIndexPath indexPath: IndexPath) {
        
        // Show Progress HUD
        interactorOutput?.showProgressHUD()
        // Delete Course From API And Storage
        courseManager.deleteCourseFromApiAndAllStorage(byCourseId: dataManager
                                    .dataProvider
                                    .course(atIndexPath: indexPath).courseId) { [unowned self] deleteCourseResult in
            
            switch deleteCourseResult {
            
            case .success:
                // Hide Progress HUD
                interactorOutput?.hideProgressHUD()
                //
                dataManager.deleteCourse(atIndexPath: indexPath)
                //
                interactorOutput?.deleteRow(atIndexPath: indexPath)
                //
                break
            //
            
            case .failure(let error):
                // Hide Progress HUD
                interactorOutput?.hideProgressHUD()                
                //
                interactorOutput?.showError(error)
                //
                break
            //
            }
            
        }
        
    }
    
}

// MARK: - Subscribe
fileprivate extension CourseListInteractor {
    
    func subscribe() {
        //
        didChangeAppearanceObservable_Subscribe()
        //
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
        deleteButtonAction_Subscribe()
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
            self?.dataManager.filterCourses(searchText)
        }
        
    }
    
    func searchBarShouldClearAction_Subscribe() {
        
        searchBarDelegate.searchBarShouldClearAction = { [weak self] in
            self?.dataManager.clearCourseFilter()
        }
        
    }
    
    func deleteButtonAction_Subscribe() {
        
        tableViewDataSource.deleteButtonAction = { [weak self] (cell) in
            self?.interactorOutput?.deleteCourseButtonClicked(cell)
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

// MARK: - Private Methods
fileprivate extension CourseListInteractor {
    
    func readAndAddCoursesToDataProvider() {
        dataManager.readAndAddCoursesToDataProvider()
    }
    
    func checkResultAndExecuteReloadDataOrShowError(_ result: MDOperationResultWithoutCompletion<Void>) {
        switch result {
        case .success:
            self.interactorOutput?.reloadData()
        case .failure(let error):
            self.interactorOutput?.showError(error)
        }
        
    }
    
}
