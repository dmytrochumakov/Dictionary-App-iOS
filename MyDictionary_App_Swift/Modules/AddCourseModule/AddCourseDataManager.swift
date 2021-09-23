//
//  AddCourseDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 23.09.2021.

import Foundation

protocol AddCourseDataManagerInputProtocol {
    
}

protocol AddCourseDataManagerOutputProtocol: AnyObject {
    
}

protocol AddCourseDataManagerProtocol: AddCourseDataManagerInputProtocol {
    var dataProvider: AddCourseDataProviderProtocol { get }
    var dataManagerOutput: AddCourseDataManagerOutputProtocol? { get set }
}

final class AddCourseDataManager: AddCourseDataManagerProtocol {
    
    internal let dataProvider: AddCourseDataProviderProtocol
    internal weak var dataManagerOutput: AddCourseDataManagerOutputProtocol?
    
    init(dataProvider: AddCourseDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
