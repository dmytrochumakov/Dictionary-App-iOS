//
//  AddWordPresenter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 27.09.2021.

import UIKit

protocol AddWordPresenterInputProtocol {
    
}

protocol AddWordPresenterOutputProtocol: AnyObject {
    
}

protocol AddWordPresenterProtocol: AddWordPresenterInputProtocol,
                                   AddWordInteractorOutputProtocol {
    var presenterOutput: AddWordPresenterOutputProtocol? { get set }
}

final class AddWordPresenter: NSObject, AddWordPresenterProtocol {
    
    fileprivate let interactor: AddWordInteractorInputProtocol
    fileprivate let router: AddWordRouterProtocol
    
    internal weak var presenterOutput: AddWordPresenterOutputProtocol?
    
    init(interactor: AddWordInteractorInputProtocol,
         router: AddWordRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init()
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - AddWordInteractorOutputProtocol
extension AddWordPresenter {
    
}
