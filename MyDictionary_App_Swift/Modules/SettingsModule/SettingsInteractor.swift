//
//  SettingsInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 31.05.2021.

import UIKit

protocol SettingsInteractorInputProtocol {
    
}

protocol SettingsInteractorOutputProtocol: AnyObject {
    
}

protocol SettingsInteractorProtocol: SettingsInteractorInputProtocol, SettingsDataManagerOutputProtocol {
    var interactorOutput: SettingsInteractorOutputProtocol? { get set }
}

final class SettingsInteractor: SettingsInteractorProtocol {

    fileprivate let dataManager: SettingsDataManagerInputProtocol
    internal weak var interactorOutput: SettingsInteractorOutputProtocol?
    
    init(dataManager: SettingsDataManagerInputProtocol) {
        self.dataManager = dataManager
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - SettingsDataManagerOutputProtocol
extension SettingsInteractor {
    
}
