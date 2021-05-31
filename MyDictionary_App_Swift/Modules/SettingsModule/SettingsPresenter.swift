//
//  SettingsPresenter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 31.05.2021.

import UIKit

protocol SettingsPresenterInputProtocol {
    
}

protocol SettingsPresenterOutputProtocol: AnyObject {
    
}

protocol SettingsPresenterProtocol: SettingsPresenterInputProtocol,
SettingsInteractorOutputProtocol {
    var presenterOutput: SettingsPresenterOutputProtocol? { get set }
}

final class SettingsPresenter: NSObject, SettingsPresenterProtocol {
    
    fileprivate let interactor: SettingsInteractorInputProtocol
    fileprivate let router: SettingsRouterProtocol
    
    internal weak var presenterOutput: SettingsPresenterOutputProtocol?
    
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
    
}
