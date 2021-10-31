//
//  SettingsRouter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 31.05.2021.

import UIKit

protocol SettingsRouterProtocol {
    var settingsViewController: UIViewController! { get set }
    func showPrivacyPolicy()
    func showTermsOfService()
    func showAbout()    
    func showAppSettings()
    func presentShareFeedback(withOption option: ShareFeedbackOption)
}

final class SettingsRouter: SettingsRouterProtocol {
    
    internal weak var settingsViewController: UIViewController!
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension SettingsRouter {
    
    func showPrivacyPolicy() {
        settingsViewController.show(PrivacyPolicyViewController.init(), sender: nil)
    }
    
    func showTermsOfService() {
        settingsViewController.show(TermsOfServiceViewController.init(), sender: nil)
    }
    
    func showAbout() {
        settingsViewController.show(AboutApplicationViewController.init(), sender: nil)
    }
    
    func showAppSettings() {
        
        //
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        //
        
        //
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl)
        }
        //
        
    }
    
    func presentShareFeedback(withOption option: ShareFeedbackOption) {
        settingsViewController.present(ShareFeedbackViewController.init(option: option), animated: true, completion: nil)
    }
    
}
