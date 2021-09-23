//
//  SettingsPresenter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 31.05.2021.

import Foundation

protocol SettingsPresenterInputProtocol: CollectionViewDelegateFlowLayoutPropertyProtocol,
                                         CollectionViewDataSourcePropertyProtocol {
    
    func shareFeedbackFeatureRequestClicked()
    func shareFeedbackBugReportClicked()
    
}

protocol SettingsPresenterOutputProtocol: AnyObject,
                                          AppearanceHasBeenUpdatedProtocol,
                                          MDShowErrorProtocol {
    
    func showShareFeedbackActionsSheet()
    
}

protocol SettingsPresenterProtocol: SettingsPresenterInputProtocol,
                                    SettingsInteractorOutputProtocol {
    var presenterOutput: SettingsPresenterOutputProtocol? { get set }
}

final class SettingsPresenter: NSObject,
                               SettingsPresenterProtocol {
    
    fileprivate let interactor: SettingsInteractorInputProtocol
    fileprivate let router: SettingsRouterProtocol
    
    internal weak var presenterOutput: SettingsPresenterOutputProtocol?
    
    internal var collectionViewDelegate: CollectionViewDelegateFlowLayout {
        return self.interactor.collectionViewDelegate
    }
    internal var collectionViewDataSource: CollectionViewDataSource {
        return self.interactor.collectionViewDataSource
    }
    
    init(interactor: SettingsInteractorInputProtocol,
         router: SettingsRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init()
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - SettingsInteractorOutputProtocol
extension SettingsPresenter {
    
    func appearanceHasBeenUpdated(_ newValue: AppearanceType) {
        self.presenterOutput?.appearanceHasBeenUpdated(newValue)
    }
    
    func showError(_ error: Error) {
        presenterOutput?.showError(error)
    }
    
    func showAbout() {
        router.showAbout()
    }
    
    func showAccount() {
        router.showAccount()
    }
    
    func showPrivacyPolicy() {
        router.showPrivacyPolicy()
    }
    
    func showTermsOfService() {
        router.showTermsOfService()
    }
    
    func showShareFeedbackActionsSheet() {
        presenterOutput?.showShareFeedbackActionsSheet()
    }
    
    func showShareFeedback(withOption option: ShareFeedbackOption) {
        router.presentShareFeedback(withOption: option)
    }
    
}

// MARK: - SettingsPresenterInputProtocol
extension SettingsPresenter: SettingsPresenterInputProtocol {
    
    func shareFeedbackBugReportClicked() {
        interactor.shareFeedbackBugReportClicked()
    }
    
    func shareFeedbackFeatureRequestClicked() {
        interactor.shareFeedbackFeatureRequestClicked()
    }
    
}
