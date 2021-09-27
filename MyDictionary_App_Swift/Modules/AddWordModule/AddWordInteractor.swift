//
//  AddWordInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 27.09.2021.

import UIKit

protocol AddWordInteractorInputProtocol {
    
}

protocol AddWordInteractorOutputProtocol: AnyObject {
    
}

protocol AddWordInteractorProtocol: AddWordInteractorInputProtocol,
                                    AddWordDataManagerOutputProtocol {
    var interactorOutput: AddWordInteractorOutputProtocol? { get set }
}

final class AddWordInteractor: AddWordInteractorProtocol {

    fileprivate let dataManager: AddWordDataManagerInputProtocol
    internal weak var interactorOutput: AddWordInteractorOutputProtocol?
    
    init(dataManager: AddWordDataManagerInputProtocol) {
        self.dataManager = dataManager
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - AddWordDataManagerOutputProtocol
extension AddWordInteractor {
    
}
