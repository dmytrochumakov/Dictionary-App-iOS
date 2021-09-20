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
    
    func deleteCourse(atIndexPath indexPath: IndexPath)
    
}

protocol CourseListInteractorOutputProtocol: AnyObject,
                                             AppearanceHasBeenUpdatedProtocol {
    
    func showError(_ error: Error)
    func reloadData()
    func hideKeyboard()
    func deleteCourseButtonClicked(_ cell: MDCourseListCell)
    func deleteRow(atIndexPath indexPath: IndexPath)
    
}

protocol CourseListInteractorProtocol: CourseListInteractorInputProtocol,
                                       CourseListDataManagerOutputProtocol {
    var interactorOutput: CourseListInteractorOutputProtocol? { get set }
}

final class CourseListInteractor: NSObject, CourseListInteractorProtocol {
    
    fileprivate let userMemoryStorage: MDUserMemoryStorageProtocol
    fileprivate let jwtManager: MDJWTManagerProtocol
    fileprivate let apiCourse: MDAPICourseProtocol
    fileprivate let courseStorage: MDCourseStorageProtocol
    fileprivate let dataManager: CourseListDataManagerInputProtocol
    fileprivate let fillMemoryService: MDFillMemoryServiceProtocol
    
    internal var tableViewDelegate: CourseListTableViewDelegateProtocol
    internal var tableViewDataSource: CourseListTableViewDataSourceProtocol
    internal var searchBarDelegate: MDCourseListSearchBarDelegateProtocol
    
    internal weak var interactorOutput: CourseListInteractorOutputProtocol?
    
    init(userMemoryStorage: MDUserMemoryStorageProtocol,
         jwtManager: MDJWTManagerProtocol,
         apiCourse: MDAPICourseProtocol,
         courseStorage: MDCourseStorageProtocol,
         dataManager: CourseListDataManagerInputProtocol,
         fillMemoryService: MDFillMemoryServiceProtocol,
         collectionViewDelegate: CourseListTableViewDelegateProtocol,
         collectionViewDataSource: CourseListTableViewDataSourceProtocol,
         searchBarDelegate: MDCourseListSearchBarDelegateProtocol) {
        
        self.userMemoryStorage = userMemoryStorage
        self.jwtManager = jwtManager
        self.apiCourse = apiCourse
        self.courseStorage = courseStorage
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
        
        var resultCount: Int = .zero
        
        userMemoryStorage.readFirstUser { [unowned self] readUserResult in
            
            switch readUserResult {
            
            case .success(let userResponse):
                
                jwtManager.fetchJWT(nickname: userResponse.nickname,
                                    password: userResponse.password!,
                                    userId: userResponse.userId) { [unowned self] (fetchResult) in
                    
                    switch fetchResult {
                    
                    case .success(let jwtResponse):
                        
                        apiCourse.deleteCourse(accessToken: jwtResponse.accessToken,
                                               userId: userResponse.userId,
                                               courseId: dataManager.dataProvider.course(atIndexPath: indexPath).courseId) { [unowned self] (apiDeleteCourseResult) in
                            
                            switch apiDeleteCourseResult {
                            
                            case .success:
                                //
                                courseStorage.deleteCourse(storageType: .all,
                                                           fromCourseId: dataManager.dataProvider.course(atIndexPath: indexPath).courseId) { [unowned self] (storageDeleteCourseResults) in
                                    
                                    storageDeleteCourseResults.forEach { storageDeleteCourseResult in
                                        
                                        switch storageDeleteCourseResult.result {
                                        
                                        case .success:
                                            
                                            resultCount += 1
                                            
                                            if (resultCount == storageDeleteCourseResults.count) {
                                                //
                                                dataManager.deleteCourse(atIndexPath: indexPath)
                                                //
                                                interactorOutput?.deleteRow(atIndexPath: indexPath)
                                                //
                                                break
                                            }
                                            
                                        case .failure(let error):
                                            //
                                            interactorOutput?.showError(error)
                                            //
                                            break
                                        //
                                        }
                                        
                                    }
                                    
                                }
                                
                            //
                            case .failure(let error):
                                //
                                interactorOutput?.showError(error)
                                //
                                break
                            //
                            }
                            
                        }
                        
                    case .failure(let error):
                        //
                        interactorOutput?.showError(error)
                        //
                        break
                    //
                    }
                    
                }
                
            case .failure(let error):
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
