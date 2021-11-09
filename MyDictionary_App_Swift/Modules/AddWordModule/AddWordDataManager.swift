//
//  AddWordDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 27.09.2021.

import Foundation

protocol AddWordDataManagerInputProtocol {
    var getWordText: String? { get  }
    func setWordText(_ newValue: String?)
    var getWordDescription: String? { get }
    func setWordDescription(_ newValue: String?)
    var getCourse: MDCourseListModel { get }
}

protocol AddWordDataManagerOutputProtocol: AnyObject {
    
}

protocol AddWordDataManagerProtocol: AddWordDataManagerInputProtocol {    
    var dataManagerOutput: AddWordDataManagerOutputProtocol? { get set }
}

final class AddWordDataManager: AddWordDataManagerProtocol {
    
    fileprivate var dataProvider: AddWordDataProviderProtocol
    internal weak var dataManagerOutput: AddWordDataManagerOutputProtocol?
    
    init(dataProvider: AddWordDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - AddWordDataManagerInputProtocol
extension AddWordDataManager: AddWordDataManagerInputProtocol {
    
    var getWordText: String? {
        return dataProvider.wordText
    }
    
    func setWordText(_ newValue: String?) {
        dataProvider.wordText = newValue
    }
    
    var getWordDescription: String? {
        return dataProvider.wordDescription
    }
    
    func setWordDescription(_ newValue: String?) {
        dataProvider.wordDescription = newValue
    }
    
    var getCourse: MDCourseListModel {
        return dataProvider.course
    }
    
}
