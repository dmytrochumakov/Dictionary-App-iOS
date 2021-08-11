//
//  CourseListDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 11.08.2021.

import Foundation

protocol CourseListDataManagerInputProtocol {
    
}

protocol CourseListDataManagerOutputProtocol: AnyObject {
    
}

protocol CourseListDataManagerProtocol: CourseListDataManagerInputProtocol {
    var dataProvider: CourseListDataProviderProtocol { get }
    var dataManagerOutput: CourseListDataManagerOutputProtocol? { get set }
}

final class CourseListDataManager: CourseListDataManagerProtocol {
    
    internal let dataProvider: CourseListDataProviderProtocol
    internal weak var dataManagerOutput: CourseListDataManagerOutputProtocol?
    
    init(dataProvider: CourseListDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
