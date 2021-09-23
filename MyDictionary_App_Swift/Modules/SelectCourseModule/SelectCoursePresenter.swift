//
//  SelectCoursePresenter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 23.09.2021.

import UIKit

protocol SelectCoursePresenterInputProtocol {
    
}

protocol SelectCoursePresenterOutputProtocol: AnyObject {
    
}

protocol SelectCoursePresenterProtocol: SelectCoursePresenterInputProtocol,
                                        SelectCourseInteractorOutputProtocol {
    var presenterOutput: SelectCoursePresenterOutputProtocol? { get set }
}

final class SelectCoursePresenter: NSObject, SelectCoursePresenterProtocol {
    
    fileprivate let interactor: SelectCourseInteractorInputProtocol
    fileprivate let router: SelectCourseRouterProtocol
    
    internal weak var presenterOutput: SelectCoursePresenterOutputProtocol?
    
    init(interactor: SelectCourseInteractorInputProtocol,
         router: SelectCourseRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init()
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - SelectCourseInteractorOutputProtocol
extension SelectCoursePresenter {
    
}
