//
//  EditWordPresenter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 28.09.2021.

import UIKit

protocol EditWordPresenterInputProtocol: MDViewDidLoadProtocol,
                                         MDTextFieldDelegatePropertyProtocol,
                                         MDTextViewDelegatePropertyProtocol {
    
    var getWordText: String { get }
    var editButtonIsSelected: Bool { get }
    
    func editWordButtonClicked()
    func updateButtonClicked()
    func deleteButtonClicked()
    
    func wordTextFieldDidChange(_ text: String?)
    
}

protocol EditWordPresenterOutputProtocol: AnyObject,
                                          MDShowErrorProtocol,
                                          MDShowHideProgressHUD {
    
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

protocol EditWordPresenterProtocol: EditWordPresenterInputProtocol,
                                    EditWordInteractorOutputProtocol {
    var presenterOutput: EditWordPresenterOutputProtocol? { get set }
}

final class EditWordPresenter: NSObject, EditWordPresenterProtocol {
    
    fileprivate let interactor: EditWordInteractorInputProtocol
    fileprivate let router: EditWordRouterProtocol
    
    internal weak var presenterOutput: EditWordPresenterOutputProtocol?
    
    init(interactor: EditWordInteractorInputProtocol,
         router: EditWordRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init()
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - EditWordInteractorOutputProtocol
extension EditWordPresenter: EditWordInteractorOutputProtocol {
    
    func updateVisibilityViews() {
        presenterOutput?.updateVisibilityViews()
    }
    
    func updateWordDescriptionTextViewTopConstraint() {
        presenterOutput?.updateWordDescriptionTextViewTopConstraint()
    }
    
    func showProgressHUD() {
        presenterOutput?.showProgressHUD()
    }
    
    func hideProgressHUD() {
        presenterOutput?.hideProgressHUD()
    }
    
    func showError(_ error: Error) {
        presenterOutput?.showError(error)
    }
    
    func closeModule() {
        router.closeModule()
    }
    
    func fillWordTextField(_ text: String) {
        presenterOutput?.fillWordTextField(text)
    }
    
    func fillWordDescriptionTextView(_ text: String) {
        presenterOutput?.fillWordDescriptionTextView(text)
    }
    
    func updateWordTextFieldCounter(_ count: Int) {
        presenterOutput?.updateWordTextFieldCounter(count)
    }
    
    func updateWordDescriptionTextViewCounter(_ count: Int) {
        presenterOutput?.updateWordDescriptionTextViewCounter(count)
    }
    
    func updateIsEditableWordDescriptionTextView(_ isEditable: Bool) {
        presenterOutput?.updateIsEditableWordDescriptionTextView(isEditable)
    }
    
    func makeWordDescriptionTextViewActive() {
        presenterOutput?.makeWordDescriptionTextViewActive()
    }
    
    func wordTextFieldShouldClearAction() {
        presenterOutput?.wordTextFieldShouldClearAction()
    }
    
}

// MARK: - EditWordPresenterInputProtocol
extension EditWordPresenter: EditWordPresenterInputProtocol {
    
    var getWordText: String {
        return interactor.getWordText
    }
    
    var editButtonIsSelected: Bool {
        return interactor.editButtonIsSelected
    }
    
    var textFieldDelegate: UITextFieldDelegate {
        return interactor.textFieldDelegate
    }
    
    var textViewDelegate: UITextViewDelegate {
        return interactor.textViewDelegate
    }
    
    func editWordButtonClicked() {
        interactor.editWordButtonClicked()
    }
    
    func viewDidLoad() {
        interactor.viewDidLoad()
    }
    
    func updateButtonClicked() {
        interactor.updateButtonClicked()
    }
    
    func deleteButtonClicked() {
        interactor.deleteButtonClicked()
    }
    
    func wordTextFieldDidChange(_ text: String?) {
        interactor.wordTextFieldDidChange(text)
    }
    
}
