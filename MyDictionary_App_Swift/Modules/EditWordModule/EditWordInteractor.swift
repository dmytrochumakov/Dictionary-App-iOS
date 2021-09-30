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
                                           MDShowErrorProtocol,
                                           MDCloseModuleProtocol {
    
    func updateVisibilityViews()
    func updateWordDescriptionTextViewTopConstraint()
    
    func fillWordTextField(_ text: String)
    func fillWordDescriptionTextView(_ text: String)
    
    func updateWordTextFieldCounter(_ count: Int)
    func updateWordDescriptionTextViewCounter(_ count: Int)
    
    func updateIsEditableWordDescriptionTextView(_ isEditable: Bool)
    
}

protocol EditWordInteractorProtocol: EditWordInteractorInputProtocol,
                                     EditWordDataManagerOutputProtocol {
    var interactorOutput: EditWordInteractorOutputProtocol? { get set }
}

final class EditWordInteractor: EditWordInteractorProtocol {
    
    fileprivate let dataManager: EditWordDataManagerInputProtocol
    fileprivate let wordManager: MDWordManagerProtocol
    fileprivate let bridge: MDBridgeProtocol
    
    internal weak var interactorOutput: EditWordInteractorOutputProtocol?
    
    init(dataManager: EditWordDataManagerInputProtocol,
         wordManager: MDWordManagerProtocol,
         bridge: MDBridgeProtocol) {
        
        self.dataManager = dataManager
        self.wordManager = wordManager
        self.bridge = bridge
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
        debugPrint(#function, Self.self)
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
    
}
