//
//  SettingsPresenter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 31.05.2021.

import UIKit

protocol SettingsPresenterInputProtocol: MDCollectionViewDelegateFlowLayoutPropertyProtocol,
                                         MDCollectionViewDataSourcePropertyProtocol {
    
    func shareFeedbackFeatureRequestClicked()
    func shareFeedbackBugReportClicked()
    
}

protocol SettingsPresenterOutputProtocol: AnyObject,
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
    
    internal var collectionViewDelegate: UICollectionViewDelegateFlowLayout {
        return self.interactor.collectionViewDelegate
    }
    internal var collectionViewDataSource: UICollectionViewDataSource {
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
    
    func showError(_ error: Error) {
        presenterOutput?.showError(error)
    }
    
    func showAbout() {
        router.showAbout()
    }        
    
    func showAppSettings() {
        router.showAppSettings()
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
