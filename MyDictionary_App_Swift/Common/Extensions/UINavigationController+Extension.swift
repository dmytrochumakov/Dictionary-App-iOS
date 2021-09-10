//
//  UINavigationController+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 10.09.2021.
//

import UIKit

extension UINavigationController {
    
    func setBackgroundImage(_ image: UIImage) {
        
        navigationBar.isTranslucent = false
        
        let logoImageView = UIImageView(image: image)
        logoImageView.contentMode = .scaleToFill
        logoImageView.clipsToBounds = true
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.insertSubview(logoImageView, aboveSubview: navigationBar)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor),
            logoImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            logoImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor)
        ])
        
    }
    
}
