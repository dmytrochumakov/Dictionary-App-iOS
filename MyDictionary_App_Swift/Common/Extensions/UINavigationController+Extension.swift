//
//  UINavigationController+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 10.09.2021.
//

import UIKit

extension UINavigationController {
    
    /// - Parameter isTranslucent: false
    /// - Parameter contentMode: UIView.ContentMode.scaleToFill
    /// - Parameter clipsToBounds: true
    func setNavigationBarBackgroundImage(_ image: UIImage,
                                         isTranslucent: Bool = false,
                                         contentMode: UIView.ContentMode = .scaleToFill,
                                         clipsToBounds: Bool = true,
                                         logoImageViewBackgroundColor: UIColor) {
        
        navigationBar.isTranslucent = isTranslucent
        
        let logoImageView = UIImageView(image: image)
        logoImageView.contentMode = contentMode
        logoImageView.clipsToBounds = clipsToBounds
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.backgroundColor = logoImageViewBackgroundColor
        
        view.insertSubview(logoImageView, aboveSubview: navigationBar)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor),
            logoImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            logoImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor)
        ])
        
    }
    
}
