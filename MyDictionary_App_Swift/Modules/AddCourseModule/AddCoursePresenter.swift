//
//  AddCoursePresenter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 23.09.2021.

import UIKit

protocol AddCoursePresenterInputProtocol {
    func viewDidLoad()
}

protocol AddCoursePresenterOutputProtocol: AnyObject,
                                           MDShowErrorProtocol,
                                           MDReloadDataProtocol {
    
}

protocol AddCoursePresenterProtocol: AddCoursePresenterInputProtocol,
                                     AddCourseInteractorOutputProtocol {
    var presenterOutput: AddCoursePresenterOutputProtocol? { get set }
}

final class AddCoursePresenter: NSObject,
                                AddCoursePresenterProtocol {
    
    fileprivate let interactor: AddCourseInteractorInputProtocol
    fileprivate let router: AddCourseRouterProtocol
    
    internal weak var presenterOutput: AddCoursePresenterOutputProtocol?
    
    init(interactor: AddCourseInteractorInputProtocol,
         router: AddCourseRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init()
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - AddCourseInteractorOutputProtocol
extension AddCoursePresenter {
    
    func showError(_ error: Error) {
        presenterOutput?.showError(error)
    }
    
    func reloadData() {
        presenterOutput?.reloadData()
    }
    
}

// MARK: - AddCoursePresenterInputProtocol
extension AddCoursePresenter {
    
    func viewDidLoad() {
        interactor.viewDidLoad()
    }
    
}
