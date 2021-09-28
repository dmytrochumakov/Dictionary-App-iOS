//
//  AddWordPresenter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 27.09.2021.

import UIKit

protocol AddWordPresenterInputProtocol: MDTextFieldDelegatePropertyProtocol,
                                        MDTextViewDelegatePropertyProtocol {
    func addButtonClicked()
    func wordTextFieldDidChange(_ text: String?)
    
}

protocol AddWordPresenterOutputProtocol: AnyObject,
                                         MDShowErrorProtocol,                                         
                                         MDShowHideProgressHUD {
    
    func makeWordDescriptionTextViewActive()

    func updateWordTextViewCounter(_ count: Int)
    func updateWordTextFieldCounter(_ count: Int)
    func wordTextFieldShouldClearAction()
    
}

protocol AddWordPresenterProtocol: AddWordPresenterInputProtocol,
                                   AddWordInteractorOutputProtocol {
    var presenterOutput: AddWordPresenterOutputProtocol? { get set }
}

final class AddWordPresenter: NSObject,
                              AddWordPresenterProtocol {
    
    fileprivate let interactor: AddWordInteractorInputProtocol
    fileprivate let router: AddWordRouterProtocol
    
    internal weak var presenterOutput: AddWordPresenterOutputProtocol?
    
    init(interactor: AddWordInteractorInputProtocol,
         router: AddWordRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init()
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - AddWordInteractorOutputProtocol
extension AddWordPresenter: AddWordInteractorOutputProtocol {

    func makeWordDescriptionTextViewActive() {
        presenterOutput?.makeWordDescriptionTextViewActive()
    }

    func updateWordTextViewCounter(_ count: Int) {
        presenterOutput?.updateWordTextViewCounter(count)
    }
    
    func updateWordTextFieldCounter(_ count: Int) {
        presenterOutput?.updateWordTextFieldCounter(count)
    }
    
    func wordTextFieldShouldClearAction() {
        presenterOutput?.wordTextFieldShouldClearAction()
    }
    
    func showError(_ error: Error) {
        presenterOutput?.showError(error)
    }
    
    func showProgressHUD() {
        presenterOutput?.showProgressHUD()
    }
    
    func hideProgressHUD() {
        presenterOutput?.hideProgressHUD()
    }
    
    func closeModule() {
        router.closeModule()
    }
    
}

// MARK: - AddWordPresenterInputProtocol
extension AddWordPresenter: AddWordPresenterInputProtocol {
    
    func addButtonClicked() {
        interactor.addButtonClicked()
    }
    
    func wordTextFieldDidChange(_ text: String?) {
        interactor.wordTextFieldDidChange(text)
    }
    
    var textFieldDelegate: UITextFieldDelegate {
        return interactor.textFieldDelegate
    }
    
    var textViewDelegate: UITextViewDelegate {
        return interactor.textViewDelegate
    }
    
}
