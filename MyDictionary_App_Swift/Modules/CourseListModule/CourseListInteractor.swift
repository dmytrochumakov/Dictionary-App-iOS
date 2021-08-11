//
//  CourseListInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 11.08.2021.

import UIKit

protocol CourseListInteractorInputProtocol {
    
}

protocol CourseListInteractorOutputProtocol: AnyObject {
    
}

protocol CourseListInteractorProtocol: CourseListInteractorInputProtocol,
                                       CourseListDataManagerOutputProtocol {
    var interactorOutput: CourseListInteractorOutputProtocol? { get set }
}

final class CourseListInteractor: CourseListInteractorProtocol {

    fileprivate let dataManager: CourseListDataManagerInputProtocol
    internal weak var interactorOutput: CourseListInteractorOutputProtocol?
    
    init(dataManager: CourseListDataManagerInputProtocol) {
        self.dataManager = dataManager
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - CourseListDataManagerOutputProtocol
extension CourseListInteractor {
    
}
