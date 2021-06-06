//
//  AppearancePresenter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 03.06.2021.

import UIKit

protocol AppearancePresenterInputProtocol: CollectionViewDelegateFlowLayoutPropertyProtocol,
                                           CollectionViewDataSourcePropertyProtocol {
    
}

protocol AppearancePresenterOutputProtocol: AnyObject,
                                            AppearanceHasBeenUpdatedProtocol {
    func reloadRows(_ rows: [IndexPath : AppearanceRowModel])
}

protocol AppearancePresenterProtocol: AppearancePresenterInputProtocol,
                                      AppearanceInteractorOutputProtocol {
    var presenterOutput: AppearancePresenterOutputProtocol? { get set }
}

final class AppearancePresenter: NSObject,
                                 AppearancePresenterProtocol {
    
    fileprivate let interactor: AppearanceInteractorInputProtocol
    fileprivate let router: AppearanceRouterProtocol
    
    var collectionViewDelegate: UICollectionViewDelegateFlowLayout {
        return interactor.appearanceCollectionViewDelegate
    }
    var collectionViewDataSource: UICollectionViewDataSource {
        return interactor.appearanceCollectionViewDataSource
    }
    
    internal weak var presenterOutput: AppearancePresenterOutputProtocol?
    
    init(interactor: AppearanceInteractorInputProtocol,
         router: AppearanceRouterProtocol) {
        
        self.interactor = interactor
        self.router = router
        
        super.init()
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - AppearanceInteractorOutputProtocol
extension AppearancePresenter {
    
    func reloadRows(_ rows: [IndexPath : AppearanceRowModel]) {
        presenterOutput?.reloadRows(rows)
    }
    
    func appearanceHasBeenUpdated(_ newValue: AppearanceType) {
        presenterOutput?.appearanceHasBeenUpdated(newValue)
    }
    
}
