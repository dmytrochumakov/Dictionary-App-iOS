//
//  EditWordDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 28.09.2021.

import Foundation

protocol EditWordDataManagerInputProtocol {
    var getWord: WordResponse { get }
    var getWordText: String { get }
}

protocol EditWordDataManagerOutputProtocol: AnyObject {
    
}

protocol EditWordDataManagerProtocol: EditWordDataManagerInputProtocol {
    var dataManagerOutput: EditWordDataManagerOutputProtocol? { get set }
}

final class EditWordDataManager: EditWordDataManagerProtocol {
    
    fileprivate let dataProvider: EditWordDataProviderProtocol
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

    var getWord: WordResponse {
        return dataProvider.word
    }

    var getWordText: String {
        return getWord.wordText
    }
    
}
