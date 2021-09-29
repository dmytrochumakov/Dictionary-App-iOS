//
//  EditWordInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 28.09.2021.

import UIKit

protocol EditWordInteractorInputProtocol: MDViewDidLoadProtocol {
    var getWordText: String { get }
    var editButtonIsSelected: Bool { get }
    func editWordButtonClicked()
    func updateButtonClicked()
    func deleteButtonClicked()
}

protocol EditWordInteractorOutputProtocol: AnyObject,
                                           MDShowHideProgressHUD,
                                           MDShowErrorProtocol {
    func updateVisibilityViews()
    func updateWordDescriptionTextViewTopConstraint()
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
    
    var editButtonIsSelected: Bool {
        return dataManager.getEditButtonIsSelected
    }
    
    func editWordButtonClicked() {
        //
        dataManager.setTrueSelectedEditButton()
        //
        interactorOutput?.updateWordDescriptionTextViewTopConstraint()
        //
        interactorOutput?.updateVisibilityViews()
        //
    }
    
    func viewDidLoad() {
        //
        interactorOutput?.updateVisibilityViews()
        //
    }
    
    func updateButtonClicked() {
        debugPrint(#function, Self.self)
    }
    
    func deleteButtonClicked() {
        debugPrint(#function, Self.self)
    }
    
}
