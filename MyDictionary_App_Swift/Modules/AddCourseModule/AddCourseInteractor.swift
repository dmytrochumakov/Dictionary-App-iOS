//
//  AddCourseInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 23.09.2021.

import UIKit

protocol AddCourseInteractorInputProtocol {
    
    var collectionViewDelegate: MDAddCourseCollectionViewDelegateProtocol { get }
    var collectionViewDataSource: MDAddCourseCollectionViewDataSourceProtocol { get }
    var searchBarDelegate: MDSearchBarDelegate { get }
    
    func viewDidLoad()
    
}

protocol AddCourseInteractorOutputProtocol: AnyObject,
                                            MDShowErrorProtocol,
                                            MDReloadDataProtocol {
    
}

protocol AddCourseInteractorProtocol: AddCourseInteractorInputProtocol,
                                      AddCourseDataManagerOutputProtocol {
    var interactorOutput: AddCourseInteractorOutputProtocol? { get set }
}

final class AddCourseInteractor: AddCourseInteractorProtocol {
    
    fileprivate let dataManager: AddCourseDataManagerInputProtocol
    internal var collectionViewDelegate: MDAddCourseCollectionViewDelegateProtocol
    internal var collectionViewDataSource: MDAddCourseCollectionViewDataSourceProtocol
    internal var searchBarDelegate: MDSearchBarDelegate
    internal weak var interactorOutput: AddCourseInteractorOutputProtocol?
    
    init(dataManager: AddCourseDataManagerInputProtocol,
         collectionViewDelegate: MDAddCourseCollectionViewDelegateProtocol,
         collectionViewDataSource: MDAddCourseCollectionViewDataSourceProtocol,
         searchBarDelegate: MDSearchBarDelegate) {
        
        self.collectionViewDelegate = collectionViewDelegate
        self.collectionViewDataSource = collectionViewDataSource
        self.dataManager = dataManager
        self.searchBarDelegate = searchBarDelegate
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - AddCourseDataManagerOutputProtocol
extension AddCourseInteractor {
    
    func loadAndPassLanguagesArrayToDataProviderResult(_ result: MDOperationResultWithoutCompletion<Void>) {
        
        switch result {
            
        case .success:
            
            //
            self.interactorOutput?.reloadData()
            //
            break
            
        case .failure(let error):
            //
            self.interactorOutput?.showError(error)
            //
            break
            
        }
        
    }
    
}

// MARK: - AddCourseInteractorInputProtocol
extension AddCourseInteractor {
    
    func viewDidLoad() {
        dataManager.loadAndPassLanguagesArrayToDataProvider()
    }
    
}
