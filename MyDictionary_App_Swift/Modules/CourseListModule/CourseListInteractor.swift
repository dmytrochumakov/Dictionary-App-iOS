//
//  CourseListInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 11.08.2021.

import UIKit

protocol CourseListInteractorInputProtocol: MDViewDidLoadProtocol {
    
    var tableViewDelegate: CourseListTableViewDelegateProtocol { get }
    var tableViewDataSource: CourseListTableViewDataSourceProtocol { get }
    var searchBarDelegate: MDSearchBarDelegateImplementationProtocol { get }
    
    func deleteCourse(atIndexPath indexPath: IndexPath)
    
}

protocol CourseListInteractorOutputProtocol: AnyObject,
                                             MDShowHideProgressHUD,
                                             MDHideKeyboardProtocol,
                                             MDReloadDataProtocol,
                                             MDInsertRowProtocol,
                                             MDDeleteRowProtocol,
                                             MDShowErrorProtocol {
    
    func deleteCourseButtonClicked(_ cell: MDCourseListCell)
    func showWordList(withCourse course: CDCourseEntity)
    
}

protocol CourseListInteractorProtocol: CourseListInteractorInputProtocol,
                                       CourseListDataManagerOutputProtocol {
    var interactorOutput: CourseListInteractorOutputProtocol? { get set }
}    

final class CourseListInteractor: NSObject, CourseListInteractorProtocol {
        
    fileprivate let dataManager: CourseListDataManagerInputProtocol
    fileprivate var bridge: MDBridgeProtocol
    
    internal var tableViewDelegate: CourseListTableViewDelegateProtocol
    internal var tableViewDataSource: CourseListTableViewDataSourceProtocol
    internal var searchBarDelegate: MDSearchBarDelegateImplementationProtocol
    
    internal weak var interactorOutput: CourseListInteractorOutputProtocol?
    
    init(dataManager: CourseListDataManagerInputProtocol,
         collectionViewDelegate: CourseListTableViewDelegateProtocol,
         collectionViewDataSource: CourseListTableViewDataSourceProtocol,
         searchBarDelegate: MDSearchBarDelegateImplementationProtocol,
         bridge: MDBridgeProtocol) {
                
        self.dataManager = dataManager
        self.tableViewDelegate = collectionViewDelegate
        self.tableViewDataSource = collectionViewDataSource
        self.searchBarDelegate = searchBarDelegate
        self.bridge = bridge        
        
        super.init()
        subscribe()
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
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
    
    func viewDidLoad() {
        dataManager.readAndAddCoursesToDataProvider()
    }
    
    func deleteCourse(atIndexPath indexPath: IndexPath) {
        
        // Show Progress HUD
        interactorOutput?.showProgressHUD()
        // Delete Course From API And Storage
        
        
    }
    
}

// MARK: - Subscribe
fileprivate extension CourseListInteractor {
    
    func subscribe() {
        //
        didChangeMemoryIsFilledAction_Subscribe()
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
        didAddCourseAction_Subscribe()
        //
        didSelectCourseAction_Subscribe()
        //
    }
    
    func didChangeMemoryIsFilledAction_Subscribe() {
        bridge
            .didChangeMemoryIsFilledResult = { [weak self] result in
                
                switch result {
                    
                case .success:
                    
                    DispatchQueue.main.async {
                        //
                        self?.readAndAddCoursesToDataProvider()
                        //
                    }
                    
                    //
                    break
                    //
                    
                case .failure(let error):
                    
                    DispatchQueue.main.async {
                        //
                        self?.interactorOutput?.showError(error)
                        //
                    }
                    
                    //
                    break
                    //
                    
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
    
    func didAddCourseAction_Subscribe() {
        
        bridge.didAddCourse = { [unowned self] (courseResponse) in
            //
            interactorOutput?.insertRow(atIndexPath: dataManager.addCourse(atNewCourse: courseResponse))
            //
        }
        
    }
    
    func didSelectCourseAction_Subscribe() {
        
        tableViewDelegate.didSelectCourse = { [unowned self] (course) in
            //
            interactorOutput?.showWordList(withCourse: course)
            //
        }
        
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
