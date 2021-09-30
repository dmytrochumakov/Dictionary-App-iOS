//
//  EditWordInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 28.09.2021.

import UIKit

protocol EditWordInteractorInputProtocol: MDViewDidLoadProtocol {
    
    var getWordText: String { get }
    var editButtonIsSelected: Bool { get }
    var textFieldDelegate: MDWordTextFieldDelegateImplementationProtocol { get }
    var textViewDelegate: MDWordTextViewDelegateImplementationProtocol { get }
    
    func editWordButtonClicked()
    func updateButtonClicked()
    func deleteButtonClicked()
    
    func wordTextFieldDidChange(_ text: String?)
    
}

protocol EditWordInteractorOutputProtocol: AnyObject,
                                           MDShowHideProgressHUD,
                                           MDShowErrorProtocol,
                                           MDCloseModuleProtocol {
    
    func updateVisibilityViews()
    func updateWordDescriptionTextViewTopConstraint()
    
    func fillWordTextField(_ text: String)
    func fillWordDescriptionTextView(_ text: String)
    
    func updateWordTextFieldCounter(_ count: Int)
    func updateWordDescriptionTextViewCounter(_ count: Int)
    
    func updateIsEditableWordDescriptionTextView(_ isEditable: Bool)
    
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
    fileprivate let wordManager: MDWordManagerProtocol
    fileprivate let bridge: MDBridgeProtocol
    
    var textFieldDelegate: MDWordTextFieldDelegateImplementationProtocol
    var textViewDelegate: MDWordTextViewDelegateImplementationProtocol
    
    internal weak var interactorOutput: EditWordInteractorOutputProtocol?
    
    init(dataManager: EditWordDataManagerInputProtocol,
         wordManager: MDWordManagerProtocol,
         bridge: MDBridgeProtocol,
         textFieldDelegate: MDWordTextFieldDelegateImplementationProtocol,
         textViewDelegate: MDWordTextViewDelegateImplementationProtocol) {
        
        self.dataManager = dataManager
        self.wordManager = wordManager
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
        return dataManager.getWord.wordText
    }
    
    var editButtonIsSelected: Bool {
        return dataManager.getEditButtonIsSelected
    }
    
    func editWordButtonClicked() {
        
        // Update editButtonIsSelected property
        //
        dataManager.setTrueSelectedEditButton()
        //
        
        // Fill Fields
        //
        interactorOutput?.fillWordTextField(dataManager.getWord.wordText)
        //
        interactorOutput?.fillWordDescriptionTextView(dataManager.getWord.wordDescription)
        //
        
        // Update Counters
        //
        interactorOutput?.updateWordTextFieldCounter(dataManager.getWord.wordText.count)
        //
        interactorOutput?.updateWordDescriptionTextViewCounter(dataManager.getWord.wordDescription.count)
        //
        
        // Update Is Editable Word Description Text View
        interactorOutput?.updateIsEditableWordDescriptionTextView(MDEditWordViewControllerConfiguration.WordDescriptionTextView.isEditable(editButtonIsSelected: dataManager.getEditButtonIsSelected))
        //
        
        // Update Top Constraint And isHidden in Views
        //
        interactorOutput?.updateWordDescriptionTextViewTopConstraint()
        //
        interactorOutput?.updateVisibilityViews()
        //
        
    }
    
    func viewDidLoad() {
        
        // Fill Description
        interactorOutput?.fillWordDescriptionTextView(dataManager.getWord.wordDescription)
        //
        
        // Update Counter
        interactorOutput?.updateWordDescriptionTextViewCounter(dataManager.getWord.wordDescription.count)
        //
        
        // Update Is Editable Word Description Text View
        interactorOutput?.updateIsEditableWordDescriptionTextView(MDEditWordViewControllerConfiguration.WordDescriptionTextView.isEditable(editButtonIsSelected: dataManager.getEditButtonIsSelected))
        //
        
        // Update isHidden property in Views
        interactorOutput?.updateVisibilityViews()
        //
        
    }
    
    func updateButtonClicked() {
        
        //
        if (MDConstants.Text.textIsEmpty(dataManager.getWord.wordText)) {
            interactorOutput?.showError(MDEditWordError.wordTextIsEmpty)
            return
        }
        //
        if (MDConstants.Text.textIsEmpty(dataManager.getWord.wordDescription)) {
            interactorOutput?.showError(MDEditWordError.wordDescriptionIsEmpty)
            return
        }
        //
        //
        
    }
    
    func deleteButtonClicked() {
        
        // Show Progress HUD
        interactorOutput?.showProgressHUD()
        //
        wordManager.deleteWordFromApiAndAllStorage(byUserId: dataManager.getWord.userId,
                                                   byCourseId: dataManager.getWord.courseId,
                                                   byWordId: dataManager.getWord.wordId) { [unowned self] result in
            
            switch result {
                
            case .success:
                
                // Hide Progress HUD
                interactorOutput?.hideProgressHUD()
                // Pass Deleted Word
                bridge.didDeleteWord?(dataManager.getWord)
                // Close Module
                interactorOutput?.closeModule()
                //
                break
                //
                
            case .failure(let error):
                
                // Hide Progress HUD
                interactorOutput?.hideProgressHUD()
                // Display Error
                interactorOutput?.showError(error)
                //
                break
                //
                
            }
            
        }
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
