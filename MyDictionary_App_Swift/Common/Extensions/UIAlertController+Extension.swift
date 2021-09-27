//
//  UIAlertController+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.08.2021.
//

import UIKit
import CloudKit

extension UIAlertController {
    
    static func showAlertWithOkAction(title: String,
                                      message: String?,
                                      okActionHandler: ((UIAlertAction) -> Void)? = nil,
                                      presenter: UIViewController) {
        
        let alertController = UIAlertController.init(title: title,
                                                     message: message,
                                                     preferredStyle: .alert)
        
        let okAction: UIAlertAction = .init(title: MDLocalizedText.ok.localized,
                                            style: .default,
                                            handler: okActionHandler)
        
        alertController.addAction(okAction)
        
        presenter.present(alertController, animated: true, completion: nil)
        
    }
    
}

extension UIAlertController {
    
    struct MDAlertAction {
        let title: String
        let style: UIAlertAction.Style
    }
    
    static func showActionSheet(title: String,
                                message: String?,
                                actions: [MDAlertAction],
                                handler: ((MDAlertAction) -> Void)? = nil,
                                presenter: UIViewController) {
        
        let alertController = UIAlertController.init(title: title,
                                                     message: message,
                                                     preferredStyle: .actionSheet)
        
        actions.forEach { action in
            alertController.addAction(.init(title: action.title,
                                            style: action.style,
                                            handler: { action in
                
                handler?(.init(title: action.title!, style: action.style))
                
            }))
        }
        
        presenter.present(alertController, animated: true, completion: nil)
        
    }
    
}
