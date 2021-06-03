//
//  AppearanceInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 03.06.2021.

import UIKit

protocol AppearanceInteractorInputProtocol {
    
}

protocol AppearanceInteractorOutputProtocol: AnyObject {
    
}

protocol AppearanceInteractorProtocol: AppearanceInteractorInputProtocol, AppearanceDataManagerOutputProtocol {
    var interactorOutput: AppearanceInteractorOutputProtocol? { get set }
}

final class AppearanceInteractor: AppearanceInteractorProtocol {

    fileprivate let dataManager: AppearanceDataManagerInputProtocol
    internal weak var interactorOutput: AppearanceInteractorOutputProtocol?
    
    init(dataManager: AppearanceDataManagerInputProtocol) {
        self.dataManager = dataManager
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - AppearanceDataManagerOutputProtocol
extension AppearanceInteractor {
    
}
