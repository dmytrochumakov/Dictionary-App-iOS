//
//  SettingsPresenter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 31.05.2021.

import Foundation

protocol SettingsPresenterInputProtocol: CollectionViewDelegateFlowLayoutPropertyProtocol,
                                         CollectionViewDataSourcePropertyProtocol {
    
}

protocol SettingsPresenterOutputProtocol: AnyObject,                                          
                                          AppearanceHasBeenUpdatedProtocol {
    
}

protocol SettingsPresenterProtocol: SettingsPresenterInputProtocol,
                                    SettingsInteractorOutputProtocol {
    var presenterOutput: SettingsPresenterOutputProtocol? { get set }
}

final class SettingsPresenter: NSObject,
                               SettingsPresenterProtocol {
    
    fileprivate let interactor: SettingsInteractorInputProtocol
    fileprivate let router: SettingsRouterProtocol
    
    internal weak var presenterOutput: SettingsPresenterOutputProtocol?
    
    internal var collectionViewDelegate: CollectionViewDelegateFlowLayout {
        return self.interactor.collectionViewDelegate
    }
    internal var collectionViewDataSource: CollectionViewDataSource {
        return self.interactor.collectionViewDataSource
    }
    
    init(interactor: SettingsInteractorInputProtocol,
         router: SettingsRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init()
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - SettingsInteractorOutputProtocol
extension SettingsPresenter {
    
    func appearanceHasBeenUpdated(_ newValue: AppearanceType) {
        self.presenterOutput?.appearanceHasBeenUpdated(newValue)
    }
    
    func didSelectRow(_ rowType: SettingsRowType) {
        
        switch rowType {
            
        case .about:
            break
            
        case .account:
            break
            
        case .privacyPolicy:
            router.showPrivacyPolicy()
            break
            
        case .termsOfService:
            break
            
        case .support:
            break
            
        }
        
    }
    
}
