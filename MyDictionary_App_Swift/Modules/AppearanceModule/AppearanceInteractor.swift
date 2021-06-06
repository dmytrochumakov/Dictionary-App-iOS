//
//  AppearanceInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 03.06.2021.

import UIKit

protocol AppearanceInteractorInputProtocol {
    var appearanceCollectionViewDelegate: AppearanceCollectionViewDelegateProtocol { get }
    var appearanceCollectionViewDataSource: AppearanceCollectionViewDataSourceProtocol { get }
}

protocol AppearanceInteractorOutputProtocol: AnyObject,
                                             AppearanceHasBeenUpdatedProtocol {
    func reloadRows(_ rows: [IndexPath : AppearanceRowModel])
}

protocol AppearanceInteractorProtocol: AppearanceInteractorInputProtocol,
                                       AppearanceDataManagerOutputProtocol {
    var interactorOutput: AppearanceInteractorOutputProtocol? { get set }
}

final class AppearanceInteractor: NSObject,
                                  AppearanceInteractorProtocol {
    
    fileprivate let dataManager: AppearanceDataManagerInputProtocol
    internal let appearanceCollectionViewDelegate: AppearanceCollectionViewDelegateProtocol
    internal let appearanceCollectionViewDataSource: AppearanceCollectionViewDataSourceProtocol
    internal weak var interactorOutput: AppearanceInteractorOutputProtocol?
    
    init(dataManager: AppearanceDataManagerInputProtocol,
         appearanceCollectionViewDelegate: AppearanceCollectionViewDelegateProtocol,
         appearanceCollectionViewDataSource: AppearanceCollectionViewDataSourceProtocol) {
        
        self.dataManager = dataManager
        self.appearanceCollectionViewDelegate = appearanceCollectionViewDelegate
        self.appearanceCollectionViewDataSource = appearanceCollectionViewDataSource
        
        super.init()
        subscribe()
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - AppearanceDataManagerOutputProtocol
extension AppearanceInteractor {
    
    func rowsForUpdate(_ rows: [IndexPath : AppearanceRowModel]) {
        interactorOutput?.reloadRows(rows)
    }
    
}

// MARK: - Subscribe
fileprivate extension AppearanceInteractor {
    
    func subscribe() {
        didSelectItemAtIndexPathSubscribe()
    }
    
    func didSelectItemAtIndexPathSubscribe() {
        appearanceCollectionViewDelegate.didSelectItemAtIndexPath = { [weak self] (indexPath) in
            guard let self = self else { return }
            let appearanceType = self.dataManager.dataProvider.row(atIndexPath: indexPath).rowType.appearanceType
            self.dataManager.didSelectItemAtIndexPath(indexPath)
            self.updateAppearance(appearanceType)
        }
    }
    
}

// MARK: - Update Appearance
fileprivate extension AppearanceInteractor {
    
    func updateAppearance(_ newValue: AppearanceType) {
        interactorOutput?.appearanceHasBeenUpdated(newValue)
        Appearance.current.updateAppearance(newValue)
    }
    
}
