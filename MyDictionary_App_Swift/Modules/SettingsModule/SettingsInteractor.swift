//
//  SettingsInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 31.05.2021.

import UIKit

protocol SettingsInteractorInputProtocol {
    var collectionViewDelegate: SettingsCollectionViewDelegateProtocol { get }
    var collectionViewDataSource: SettingsCollectionViewDataSourceProtocol { get }
}

protocol SettingsInteractorOutputProtocol: AnyObject {
    func didSelectAppearanceRow()
}

protocol SettingsInteractorProtocol: SettingsInteractorInputProtocol,
                                     SettingsDataManagerOutputProtocol {
    var interactorOutput: SettingsInteractorOutputProtocol? { get set }
}

final class SettingsInteractor: NSObject,
                                SettingsInteractorProtocol {
    
    fileprivate let dataManager: SettingsDataManagerInputProtocol
    
    internal var collectionViewDelegate: SettingsCollectionViewDelegateProtocol
    internal var collectionViewDataSource: SettingsCollectionViewDataSourceProtocol
    internal weak var interactorOutput: SettingsInteractorOutputProtocol?
    
    init(dataManager: SettingsDataManagerInputProtocol,
         collectionViewDelegate: SettingsCollectionViewDelegateProtocol,
         collectionViewDataSource: SettingsCollectionViewDataSourceProtocol) {
        
        self.dataManager = dataManager
        self.collectionViewDelegate = collectionViewDelegate
        self.collectionViewDataSource = collectionViewDataSource
        
        super.init()
        subscribe()
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Subscribe
fileprivate extension SettingsInteractor {
    
    func subscribe() {
        didSelectItemAtIndexPathSubscribe()
    }
    
    func didSelectItemAtIndexPathSubscribe() {
        collectionViewDelegate.didSelectItemAtIndexPath = { [weak self] (indexPath) in
            guard let rowModel = self?.dataManager.dataProvider.rowModel(atIndexPath: indexPath)
            else { return }
            switch rowModel.rowType {
            case .appearance:
                self?.interactorOutput?.didSelectAppearanceRow()
                break
            }
        }
    }
    
}
