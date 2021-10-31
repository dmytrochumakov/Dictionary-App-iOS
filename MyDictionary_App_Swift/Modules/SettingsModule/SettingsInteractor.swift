//
//  SettingsInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 31.05.2021.

import MessageUI

protocol SettingsInteractorInputProtocol {
    var collectionViewDelegate: SettingsCollectionViewDelegateProtocol { get }
    var collectionViewDataSource: SettingsCollectionViewDataSourceProtocol { get }
    func shareFeedbackFeatureRequestClicked()
    func shareFeedbackBugReportClicked()
}

protocol SettingsInteractorOutputProtocol: AnyObject,
                                           MDShowErrorProtocol {
    
    func showAbout()    
    func showAppSettings()
    func showPrivacyPolicy()
    func showTermsOfService()
    func showShareFeedbackActionsSheet()
    func showShareFeedback(withOption option: ShareFeedbackOption)
    
}

protocol SettingsInteractorProtocol: SettingsInteractorInputProtocol,
                                     SettingsDataManagerOutputProtocol {
    var interactorOutput: SettingsInteractorOutputProtocol? { get set }
}

final class SettingsInteractor: NSObject,
                                SettingsInteractorProtocol {
    
    fileprivate let dataManager: SettingsDataManagerInputProtocol
    
    internal var collectionViewDelegate: SettingsCollectionViewDelegateProtocol
    internal var collectionViewDataSource: SettingsCollectionViewDataSourceProtocol
    internal weak var interactorOutput: SettingsInteractorOutputProtocol?
    
    init(dataManager: SettingsDataManagerInputProtocol,
         collectionViewDelegate: SettingsCollectionViewDelegateProtocol,
         collectionViewDataSource: SettingsCollectionViewDataSourceProtocol) {
        
        self.dataManager = dataManager
        self.collectionViewDelegate = collectionViewDelegate
        self.collectionViewDataSource = collectionViewDataSource
        
        super.init()
        subscribe()
        
    }
    
    deinit {
        debugPrint(#function, Self.self)        
    }
    
}

// MARK: - SettingsInteractorInputProtocol
extension SettingsInteractor: SettingsInteractorInputProtocol {
    
    func shareFeedbackBugReportClicked() {
        guard MFMailComposeViewController.canSendMail() else {
            self.interactorOutput?.showError(MDSettingsError.mailServicesAreNotAvailable)
            return
        }
        interactorOutput?.showShareFeedback(withOption: .bugReport)
    }
    
    func shareFeedbackFeatureRequestClicked() {
        guard MFMailComposeViewController.canSendMail() else {
            self.interactorOutput?.showError(MDSettingsError.mailServicesAreNotAvailable)
            return
        }
        interactorOutput?.showShareFeedback(withOption: .featureRequest)
    }
    
}

// MARK: - SettingsDataManagerOutputProtocol
extension SettingsInteractor {
    
}

// MARK: - Subscribe
fileprivate extension SettingsInteractor {
    
    func subscribe() {
        didSelectItemAtIndexPath_Subscribe()
    }
    
    func didSelectItemAtIndexPath_Subscribe() {
        
        collectionViewDelegate.didSelectItemAtIndexPath = { [weak self] (indexPath) in
            
            guard let rowModel = self?.dataManager.dataProvider.rowModel(atIndexPath: indexPath) else { return }
            
            switch rowModel.rowType {
                
            case .about:
                self?.interactorOutput?.showAbout()
                break
            
            case .appLanguage:
                self?.interactorOutput?.showAppSettings()
                break
                
            case .privacyPolicy:
                self?.interactorOutput?.showPrivacyPolicy()
                break
                
            case .termsOfService:
                self?.interactorOutput?.showTermsOfService()
                break
                
            case .shareFeedback:
                self?.interactorOutput?.showShareFeedbackActionsSheet()
                break
            }
            
            
        }
        
    }
    
}
