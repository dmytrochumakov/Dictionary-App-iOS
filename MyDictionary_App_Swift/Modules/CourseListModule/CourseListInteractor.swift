//
//  CourseListInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 11.08.2021.

import UIKit

protocol CourseListInteractorInputProtocol {
    var tableViewDelegate: CourseListTableViewDelegateProtocol { get }
    var tableViewDataSource: CourseListTableViewDataSourceProtocol { get }
}

protocol CourseListInteractorOutputProtocol: AnyObject {
    
}

protocol CourseListInteractorProtocol: CourseListInteractorInputProtocol,
                                       CourseListDataManagerOutputProtocol {
    var interactorOutput: CourseListInteractorOutputProtocol? { get set }
}

final class CourseListInteractor: CourseListInteractorProtocol {

    fileprivate let dataManager: CourseListDataManagerInputProtocol
    
    internal var tableViewDelegate: CourseListTableViewDelegateProtocol
    internal var tableViewDataSource: CourseListTableViewDataSourceProtocol
    internal weak var interactorOutput: CourseListInteractorOutputProtocol?
    
    init(dataManager: CourseListDataManagerInputProtocol,
         tableViewDelegate: CourseListTableViewDelegateProtocol,
         tableViewDataSource: CourseListTableViewDataSourceProtocol) {
        
        self.dataManager = dataManager
        self.tableViewDelegate = tableViewDelegate
        self.tableViewDataSource = tableViewDataSource
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - CourseListDataManagerOutputProtocol
extension CourseListInteractor {
    
}
