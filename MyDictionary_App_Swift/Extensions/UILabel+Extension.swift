//
//  UILabel+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 05.06.2021.
//

import UIKit

extension UILabel {
    
    func configure(withConfiguration configuration: StandardLabelConfigurationProtocol) {
        self.font = configuration.font
        self.textColor = configuration.textColor
        self.textAlignment = configuration.textAlignment
        self.numberOfLines = configuration.numberOfLines
    }
    
    func configure(withConfiguration configuration: StandardLabelConfigurationProtocol,
                   andText text: String) {
        self.configure(withConfiguration: configuration)
        self.text = text
    }
    
}
