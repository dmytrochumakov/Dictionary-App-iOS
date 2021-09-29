//
//  EditWordPresenter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 28.09.2021.

import UIKit

protocol EditWordPresenterInputProtocol: MDViewDidLoadProtocol {
    
    var getWordText: String { get }
    var editButtonIsSelected: Bool { get }
    
    func editWordButtonClicked()
    func updateButtonClicked()
    func deleteButtonClicked()
    
}

protocol EditWordPresenterOutputProtocol: AnyObject,
                                          MDShowErrorProtocol,
                                          MDShowHideProgressHUD {
    
    func updateVisibilityViews()
    func updateWordDescriptionTextViewTopConstraint()
    
    func fillWordTextField(_ text: String)
    func fillWordDescriptionTextView(_ text: String)
    
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
    
}

// MARK: - EditWordPresenterInputProtocol
extension EditWordPresenter: EditWordPresenterInputProtocol {
    
    var getWordText: String {
        return interactor.getWordText
    }
    
    var editButtonIsSelected: Bool {
        return interactor.editButtonIsSelected
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
    
}
