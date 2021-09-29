//
//  EditWordInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 28.09.2021.

import UIKit

protocol EditWordInteractorInputProtocol: MDViewDidLoadProtocol {
    var getWordText: String { get }
    func editWordButtonClicked()
    func updateButtonClicked()
    func deleteButtonClicked()
}

protocol EditWordInteractorOutputProtocol: AnyObject {
    
}

protocol EditWordInteractorProtocol: EditWordInteractorInputProtocol,
                                     EditWordDataManagerOutputProtocol {
    var interactorOutput: EditWordInteractorOutputProtocol? { get set }
}

final class EditWordInteractor: EditWordInteractorProtocol {
    
    fileprivate let dataManager: EditWordDataManagerInputProtocol
    internal weak var interactorOutput: EditWordInteractorOutputProtocol?
    
    init(dataManager: EditWordDataManagerInputProtocol) {
        self.dataManager = dataManager
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - EditWordDataManagerOutputProtocol
extension EditWordInteractor: EditWordDataManagerOutputProtocol {
    
}

// MARK: - EditWordInteractorInputProtocol
extension EditWordInteractor: EditWordInteractorInputProtocol {
    
    var getWordText: String {
        return dataManager.getWordText
    }
    
    func editWordButtonClicked() {
        debugPrint(#function, Self.self)
    }
    
    func viewDidLoad() {
        debugPrint(#function, Self.self)
    }
    
    func updateButtonClicked() {
        debugPrint(#function, Self.self)
    }
    
    func deleteButtonClicked() {
        debugPrint(#function, Self.self)
    }
    
}
