//
//  EditWordPresenter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 28.09.2021.

import UIKit

protocol EditWordPresenterInputProtocol {
    var getWordText: String { get }
}

protocol EditWordPresenterOutputProtocol: AnyObject {
    
}

protocol EditWordPresenterProtocol: EditWordPresenterInputProtocol,
                                    EditWordInteractorOutputProtocol {
    var presenterOutput: EditWordPresenterOutputProtocol? { get set }
}

final class EditWordPresenter: NSObject, EditWordPresenterProtocol {
    
    fileprivate let interactor: EditWordInteractorInputProtocol
    fileprivate let router: EditWordRouterProtocol
    
    internal weak var presenterOutput: EditWordPresenterOutputProtocol?
    
    init(interactor: EditWordInteractorInputProtocol,
         router: EditWordRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init()
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - EditWordInteractorOutputProtocol
extension EditWordPresenter: EditWordInteractorOutputProtocol {
    
}

// MARK: - EditWordPresenterInputProtocol
extension EditWordPresenter: EditWordPresenterInputProtocol {
    
    var getWordText: String {
        return interactor.getWordText
    }
    
}
