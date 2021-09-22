//
//  UIAlertController+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.08.2021.
//

import UIKit

extension UIAlertController {
    
    static func showAlertWithOkAction(title: String,
                                      message: String?,
                                      okActionHandler: ((UIAlertAction) -> Void)? = nil,
                                      presenter: UIViewController) {
        
        let alertController = UIAlertController.init(title: title,
                                           message: message,
                                           preferredStyle: .alert)
        
        let okAction: UIAlertAction = .init(title: LocalizedText.ok.localized,
                                            style: .default,
                                            handler: okActionHandler)
        
        alertController.addAction(okAction)
        
        presenter.present(alertController, animated: true, completion: nil)
        
    }
    
}
