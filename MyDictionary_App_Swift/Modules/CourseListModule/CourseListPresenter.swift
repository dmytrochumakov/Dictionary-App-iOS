//
//  CourseListPresenter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 11.08.2021.

import UIKit

protocol CourseListPresenterInputProtocol {
    
}

protocol CourseListPresenterOutputProtocol: AnyObject {
    
}

protocol CourseListPresenterProtocol: CourseListPresenterInputProtocol,
                                      CourseListInteractorOutputProtocol {
    var presenterOutput: CourseListPresenterOutputProtocol? { get set }
}

final class CourseListPresenter: NSObject, CourseListPresenterProtocol {
    
    fileprivate let interactor: CourseListInteractorInputProtocol
    fileprivate let router: CourseListRouterProtocol
    
    internal weak var presenterOutput: CourseListPresenterOutputProtocol?
    
    init(interactor: CourseListInteractorInputProtocol,
         router: CourseListRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init()
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - CourseListInteractorOutputProtocol
extension CourseListPresenter {
    
}
