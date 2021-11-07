//
//  EditWordDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 28.09.2021.

import Foundation

protocol EditWordDataManagerInputProtocol {
    
    var getWord: CDWordEntity { get }
    
    var updatedWordTextAndDescriptionIsEqualToInitialValue: Bool { get }
        
    func setWordText(_ text: String?)
    func setWordDescription(_ text: String?)
    
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
    
    var getWord: CDWordEntity {
        return dataProvider.word
    }
    
    var updatedWordTextAndDescriptionIsEqualToInitialValue: Bool {
        return (updatedWordTextIsEqualToInitialValue && updatedWordDescriptionIsEqualToInitialValue)
    }
    
    func setWordText(_ text: String?) {
        guard let text = text else { return }
        dataProvider.word.wordText = text
    }
    
    func setWordDescription(_ text: String?) {
        guard let text = text else { return }
        dataProvider.word.wordDescription = text
    }
    
}

// MARK: - Private Methods
fileprivate extension EditWordDataManager {
    
    var updatedWordTextIsEqualToInitialValue: Bool {
        return (dataProvider.word.wordText == dataProvider.copiedWord.wordText)
    }
    
    var updatedWordDescriptionIsEqualToInitialValue: Bool {
        return (dataProvider.word.wordDescription == dataProvider.copiedWord.wordDescription)
    }
    
}
