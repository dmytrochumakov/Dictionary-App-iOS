//
//  SelectCourseDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 23.09.2021.

import Foundation

protocol SelectCourseDataManagerInputProtocol {
    
}

protocol SelectCourseDataManagerOutputProtocol: AnyObject {
    
}

protocol SelectCourseDataManagerProtocol: SelectCourseDataManagerInputProtocol {
    var dataProvider: SelectCourseDataProviderProtocol { get }
    var dataManagerOutput: SelectCourseDataManagerOutputProtocol? { get set }
}

final class SelectCourseDataManager: SelectCourseDataManagerProtocol {
    
    internal let dataProvider: SelectCourseDataProviderProtocol
    internal weak var dataManagerOutput: SelectCourseDataManagerOutputProtocol?
    
    init(dataProvider: SelectCourseDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
