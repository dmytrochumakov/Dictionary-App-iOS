//
//  EditWordInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 28.09.2021.

import UIKit

protocol EditWordInteractorInputProtocol: MDViewDidLoadProtocol {
    
    var getWordText: String { get }
    
    var textFieldDelegate: MDWordTextFieldDelegateImplementationProtocol { get }
    var textViewDelegate: MDWordTextViewDelegateImplementationProtocol { get }
    
    func updateButtonClicked()
    func deleteButtonClicked()
    
    func wordTextFieldDidChange(_ text: String?)
    
}

protocol EditWordInteractorOutputProtocol: AnyObject,
                                           MDShowHideProgressHUD,
                                           MDShowErrorProtocol,
                                           MDCloseModuleProtocol {
    
    func fillWordTextField(_ text: String)
    func fillWordDescriptionTextView(_ text: String)
    
    func updateWordTextFieldCounter(_ count: Int)
    func updateWordDescriptionTextViewCounter(_ count: Int)
    
    func makeWordDescriptionTextViewActive()
    
    func wordTextFieldShouldClearAction()
    
}

protocol EditWordInteractorProtocol: EditWordInteractorInputProtocol,
                                     EditWordDataManagerOutputProtocol {
    var interactorOutput: EditWordInteractorOutputProtocol? { get set }
}

final class EditWordInteractor: NSObject,
                                EditWordInteractorProtocol {
    
    fileprivate let dataManager: EditWordDataManagerInputProtocol
    fileprivate let bridge: MDBridgeProtocol
    
    var textFieldDelegate: MDWordTextFieldDelegateImplementationProtocol
    var textViewDelegate: MDWordTextViewDelegateImplementationProtocol
    
    internal weak var interactorOutput: EditWordInteractorOutputProtocol?
    
    init(dataManager: EditWordDataManagerInputProtocol,
         bridge: MDBridgeProtocol,
         textFieldDelegate: MDWordTextFieldDelegateImplementationProtocol,
         textViewDelegate: MDWordTextViewDelegateImplementationProtocol) {
        
        self.dataManager = dataManager        
        self.bridge = bridge
        self.textFieldDelegate = textFieldDelegate
        self.textViewDelegate = textViewDelegate
        
        super.init()
        subscribe()
        
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
        return dataManager.getWord.wordText!
    }
    
    func viewDidLoad() {
        
        // Fill Fields
        //
        interactorOutput?.fillWordTextField(dataManager.getWord.wordText!)
        //
        interactorOutput?.fillWordDescriptionTextView(dataManager.getWord.wordDescription!)
        //
        
        // Update Counters
        //
        interactorOutput?.updateWordTextFieldCounter(dataManager.getWord.wordText!.count)
        //
        interactorOutput?.updateWordDescriptionTextViewCounter(dataManager.getWord.wordDescription!.count)
        //
        
    }
    
    func updateButtonClicked() {
        
        // Check If Word Text Is Empty
        //
        if (MDConstants.Text.textIsEmpty(dataManager.getWord.wordText)) {
            interactorOutput?.showError(MDEditWordError.wordTextIsEmpty)
            return
        }
        
        // Check If Word Description Text Is Empty
        //
        if (MDConstants.Text.textIsEmpty(dataManager.getWord.wordDescription)) {
            interactorOutput?.showError(MDEditWordError.wordDescriptionIsEmpty)
            return
        }
        
        // Check If Updated Word Text And Description is Equal Initial Value
        //
        if (dataManager.updatedWordTextAndDescriptionIsEqualToInitialValue) {
            
            // Close Module
            interactorOutput?.closeModule()
            //
            
        } else {
            
            // Show Progress HUD
            interactorOutput?.showProgressHUD()
            //
            
            // Update Word In Api And All Storage
            //
        }
        
    }
    
    func deleteButtonClicked() {
        
        // Show Progress HUD
        interactorOutput?.showProgressHUD()
        //
        
        //
    }
    
    func wordTextFieldDidChange(_ text: String?) {
        dataManager.setWordText(text)
    }
    
}

// MARK: - Subscribe
fileprivate extension EditWordInteractor {
    
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
            self?.interactorOutput?.updateWordDescriptionTextViewCounter(count)
            //
        }
        
    }
    
}
