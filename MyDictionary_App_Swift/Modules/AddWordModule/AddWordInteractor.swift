//
//  AddWordInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 27.09.2021.

import UIKit

protocol AddWordInteractorInputProtocol {
    var textFieldDelegate: MDAddWordTextFieldDelegateProtocol { get }
    var textViewDelegate: MDAddWordTextViewDelegateProtocol { get }
    func addButtonClicked()
    func wordTextFieldDidChange(_ text: String?)
}

protocol AddWordInteractorOutputProtocol: AnyObject {
    
    func makeWordDescriptionTextViewActive()
    
    func updateWordTextFieldCounter(_ count: Int)
    func updateWordTextViewCounter(_ count: Int)
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
    var textViewDelegate: MDAddWordTextViewDelegateProtocol
    
    internal weak var interactorOutput: AddWordInteractorOutputProtocol?
    
    init(dataManager: AddWordDataManagerInputProtocol,
         textFieldDelegate: MDAddWordTextFieldDelegateProtocol,
         textViewDelegate: MDAddWordTextViewDelegateProtocol) {
        
        self.dataManager = dataManager
        self.textFieldDelegate = textFieldDelegate
        self.textViewDelegate = textViewDelegate
        
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
    
    func wordTextFieldDidChange(_ text: String?) {
        dataManager.setWordText(text)
    }
    
}

// MARK: - Subscribe
fileprivate extension AddWordInteractor {
    
    func subscribe() {
        //
        wordTextField_ShouldReturnAction_Subscribe()
        //
        update_WordTextField_CounterAction_Subscribe()
        //
        wordTextField_ShouldClearAction_Subscribe()
        //
        wordDescriptionTextView_DidChangeAction_Subscribe()
        //
        update_WordDescriptionTextView_CounterAction_Subscribe()
        //
    }
    
    func wordTextField_ShouldReturnAction_Subscribe() {
        
        textFieldDelegate.wordTextFieldShouldReturnAction = { [weak self] in
            self?.interactorOutput?.makeWordDescriptionTextViewActive()
        }
        
    }
    
    func update_WordTextField_CounterAction_Subscribe() {
        
        textFieldDelegate.updateWordTextFieldCounterAction = { [weak self] (count) in
            self?.interactorOutput?.updateWordTextFieldCounter(count)
        }
        
    }
    
    func wordTextField_ShouldClearAction_Subscribe() {
        
        textFieldDelegate.wordTextFieldShouldClearAction = { [weak self] in
            self?.interactorOutput?.wordTextFieldShouldClearAction()
        }
        
    }
    
    func wordDescriptionTextView_DidChangeAction_Subscribe() {
        
        textViewDelegate.wordDescriptionTextViewDidChangeAction = { [weak self] (text) in
            //
            self?.dataManager.setWordDescription(text)
            //
        }
        
    }
    
    func update_WordDescriptionTextView_CounterAction_Subscribe() {
        
        textViewDelegate.updateWordDescriptionTextViewCounterAction = { [weak self] (count) in
            //
            self?.interactorOutput?.updateWordTextViewCounter(count)
            //
        }
        
    }
    
}
