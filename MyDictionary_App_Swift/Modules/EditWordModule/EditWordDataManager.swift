//
//  EditWordDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 28.09.2021.

import Foundation

protocol EditWordDataManagerInputProtocol {
    var getWordText: String { get }
    var getWordDescription: String { get }
    var getEditButtonIsSelected: Bool { get }
    func setTrueSelectedEditButton()
}

protocol EditWordDataManagerOutputProtocol: AnyObject {
    
}

protocol EditWordDataManagerProtocol: EditWordDataManagerInputProtocol {
    var dataManagerOutput: EditWordDataManagerOutputProtocol? { get set }
}

final class EditWordDataManager: EditWordDataManagerProtocol {
    
    fileprivate var dataProvider: EditWordDataProviderProtocol
    internal weak var dataManagerOutput: EditWordDataManagerOutputProtocol?
    
    init(dataProvider: EditWordDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - EditWordDataManagerInputProtocol
extension EditWordDataManager: EditWordDataManagerInputProtocol {

    var getWordText: String {
        return dataProvider.word.wordText
    }
    
    var getWordDescription: String {
        return dataProvider.word.wordDescription
    }
    
    var getEditButtonIsSelected: Bool {
        return dataProvider.editButtonIsSelected
    }
    
    func setTrueSelectedEditButton() {
        dataProvider.editButtonIsSelected = true
    }
    
}
