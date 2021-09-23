//
//  ShareFeedbackViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 22.09.2021.

import MessageUI

final class ShareFeedbackViewController: MFMailComposeViewController {

    fileprivate let option: ShareFeedbackOption
    
    init(option: ShareFeedbackOption) {
        self.option = option
        super.init(nibName: nil, bundle: nil)
        configureUI()
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}

// MARK: - MFMailComposeViewControllerDelegate
extension ShareFeedbackViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        debugPrint(#function, Self.self, "result: ", result, "error: ", error ?? "")
        self.dismiss(animated: true)
    }
    
}

// MARK: - Configure UI
fileprivate extension ShareFeedbackViewController {
    
    func configureUI() {
        // Configure the fields of the interface.
        setToRecipients([MDConstants.ShareFeedback.recipientEmail])
        setSubject(option.description)
        //
        self.mailComposeDelegate = self
        //
    }
    
}
