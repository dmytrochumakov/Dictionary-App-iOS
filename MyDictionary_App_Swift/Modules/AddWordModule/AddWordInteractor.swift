//
//  AddWordInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 27.09.2021.

import UIKit

protocol AddWordInteractorInputProtocol {
    var textFieldDelegate: MDAddWordTextFieldDelegateProtocol { get }
    func addButtonClicked()
}

protocol AddWordInteractorOutputProtocol: AnyObject {
    
    func makeWordDescriptionTextViewActive()
    
    func updateWordTextFieldCounter(_ count: Int)
    func wordTextFieldShouldClearAction()
    
}

protocol AddWordInteractorProtocol: AddWordInteractorInputProtocol,
                                    AddWordDataManagerOutputProtocol {
    var interactorOutput: AddWordInteractorOutputProtocol? { get set }
}

final class AddWordInteractor: NSObject,
                               AddWordInteractorProtocol {
    
    fileprivate let dataManager: AddWordDataManagerInputProtocol
    var textFieldDelegate: MDAddWordTextFieldDelegateProtocol
    
    internal weak var interactorOutput: AddWordInteractorOutputProtocol?
    
    init(dataManager: AddWordDataManagerInputProtocol,
         textFieldDelegate: MDAddWordTextFieldDelegateProtocol) {
        
        self.dataManager = dataManager
        self.textFieldDelegate = textFieldDelegate
        
        super.init()
        subscribe()
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - AddWordDataManagerOutputProtocol
extension AddWordInteractor: AddWordDataManagerOutputProtocol {
    
}

// MARK: - AddWordInteractorInputProtocol
extension AddWordInteractor: AddWordInteractorInputProtocol {
    
    func addButtonClicked() {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Subscribe
fileprivate extension AddWordInteractor {
    
    func subscribe() {
        //
        textFieldShouldReturnAction_Subscribe()
        //
        textFieldUpdateWordTextFieldCounterAction_Subscribe()
        //
        wordTextFieldShouldClearAction_Subscribe()
        //
    }
    
    func textFieldShouldReturnAction_Subscribe() {
        
        textFieldDelegate.wordTextFieldShouldReturnAction = { [weak self] in
            self?.interactorOutput?.makeWordDescriptionTextViewActive()
        }
        
    }
    
    func textFieldUpdateWordTextFieldCounterAction_Subscribe() {
        
        textFieldDelegate.updateWordTextFieldCounterAction = { [weak self] (count) in
            self?.interactorOutput?.updateWordTextFieldCounter(count)
        }
        
    }
    
    func wordTextFieldShouldClearAction_Subscribe() {
        
        textFieldDelegate.wordTextFieldShouldClearAction = { [weak self] in
            self?.interactorOutput?.wordTextFieldShouldClearAction()
        }
        
    }
    
}
