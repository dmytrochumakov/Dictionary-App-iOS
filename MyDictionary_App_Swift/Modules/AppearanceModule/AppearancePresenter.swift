//
//  AppearancePresenter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 03.06.2021.

import UIKit

protocol AppearancePresenterInputProtocol {
    
}

protocol AppearancePresenterOutputProtocol: AnyObject {
    
}

protocol AppearancePresenterProtocol: AppearancePresenterInputProtocol,
                                      AppearanceInteractorOutputProtocol {
    var presenterOutput: AppearancePresenterOutputProtocol? { get set }
}

final class AppearancePresenter: NSObject, AppearancePresenterProtocol {
    
    fileprivate let interactor: AppearanceInteractorInputProtocol
    let router: AppearanceRouterProtocol
    
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
    
}
