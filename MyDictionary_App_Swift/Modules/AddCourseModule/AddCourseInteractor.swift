//
//  AddCourseInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 23.09.2021.

import UIKit

protocol AddCourseInteractorInputProtocol: MDViewDidLoadProtocol {
    
    var collectionViewDelegate: MDAddCourseCollectionViewDelegateProtocol { get }
    var collectionViewDataSource: MDAddCourseCollectionViewDataSourceProtocol { get }
    var searchBarDelegate: MDSearchBarDelegateImplementationProtocol { get }
    
    func addButtonClicked()
    
}

protocol AddCourseInteractorOutputProtocol: AnyObject,
                                            MDShowErrorProtocol,
                                            MDReloadDataProtocol,
                                            MDHideKeyboardProtocol,
                                            MDShowHideProgressHUD,
                                            MDCloseModuleProtocol {
    
    func selectAndDeselectRow(at results: [Bool : IndexPath])
    
}

protocol AddCourseInteractorProtocol: AddCourseInteractorInputProtocol,
                                      AddCourseDataManagerOutputProtocol {
    var interactorOutput: AddCourseInteractorOutputProtocol? { get set }
}

final class AddCourseInteractor: NSObject,
                                 AddCourseInteractorProtocol {
    
    fileprivate let dataManager: AddCourseDataManagerInputProtocol
    fileprivate let bridge: MDBridgeProtocol
    fileprivate let courseCoreDataStorage: MDCourseCoreDataStorageProtocol
    
    internal var collectionViewDelegate: MDAddCourseCollectionViewDelegateProtocol
    internal var collectionViewDataSource: MDAddCourseCollectionViewDataSourceProtocol
    internal var searchBarDelegate: MDSearchBarDelegateImplementationProtocol
    
    internal weak var interactorOutput: AddCourseInteractorOutputProtocol?
    
    init(dataManager: AddCourseDataManagerInputProtocol,
         collectionViewDelegate: MDAddCourseCollectionViewDelegateProtocol,
         collectionViewDataSource: MDAddCourseCollectionViewDataSourceProtocol,
         searchBarDelegate: MDSearchBarDelegateImplementationProtocol,
         bridge: MDBridgeProtocol,
         courseCoreDataStorage: MDCourseCoreDataStorageProtocol) {
        
        self.collectionViewDelegate = collectionViewDelegate
        self.collectionViewDataSource = collectionViewDataSource
        self.dataManager = dataManager
        self.searchBarDelegate = searchBarDelegate
        self.bridge = bridge
        self.courseCoreDataStorage = courseCoreDataStorage
        
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
    
    func addButtonClicked() {
        
        if (dataManager.selectedRow == nil) {
            
            //
            interactorOutput?.showError(MDAddCourseError.pleaseSelectACourse)
            //
            
            //
            return
            //
            
        } else {
            
            //
            interactorOutput?.showProgressHUD()
            //
            
            //
            courseCoreDataStorage.createCourse(uuid: .init(),
                                               languageId: dataManager.selectedRow!.languageResponse.id,
                                               createdAt: .init()) { [unowned self] createResult in
                
                switch createResult {
                    
                case .success(let cdCourseEntity):
                    
                    DispatchQueue.main.async {
                        
                        //
                        self.interactorOutput?.hideProgressHUD()
                        //
                        
                        //
                        self.bridge.didAddCourse?(.init(course: cdCourseEntity,
                                                        language: dataManager.selectedRow!.languageResponse))
                        //
                        
                        //
                        self.interactorOutput?.closeModule()
                        //
                        
                    }
                    
                    //
                    break
                    //
                    
                case .failure(let error):
                    
                    DispatchQueue.main.async {
                        
                        //
                        self.interactorOutput?.hideProgressHUD()
                        //
                        
                        //
                        self.interactorOutput?.showError(error)
                        //
                        
                    }
                    
                    //
                    break
                    //
                    
                }
                
            }
            //
            
        }
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
        collectionViewDelegateDidSelectItemAction_Subscribe()
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
    
    func collectionViewDelegateDidSelectItemAction_Subscribe() {
        
        collectionViewDelegate.didSelectItem = { [unowned self] (item) in
            
            //
            interactorOutput?.selectAndDeselectRow(at: dataManager.selectAndDeselectRow(item))
            //
            
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
