//
//  MDEditWordViewControllerConfiguration.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.09.2021.
//

import UIKit

struct MDEditWordViewControllerConfiguration {
    
    struct WordTextField {
        
        static let leftOffset: CGFloat = 16
        static let rightOffset: CGFloat = 16
        static let height: CGFloat = 48
        
        static func topOffset(fromNavigationController navigationController: UINavigationController?) -> CGFloat {
            return MDConstants.NavigationBar.height(fromNavigationController: navigationController, prefersLargeTitles: false) + 24
        }
        
    }
    
    struct WordDescriptionTextView {
        
        static let topOffset: CGFloat = 16
        static let leftOffset: CGFloat = 16
        static let rightOffset: CGFloat = 16
        static let height: CGFloat = 290
                
    }
    
    struct WordDescriptionCounterLabel {
        
        static let topOffset: CGFloat = 4
        static let leftOffset: CGFloat = .zero
        static let rightOffset: CGFloat = 4
        
    }
    
    struct UpdateButton {
        
        static let topOffset: CGFloat = 16
        static let leftOffset: CGFloat = 16
        static let rightOffset: CGFloat = 16
        static let height: CGFloat = 48
        
    }
    
    struct DeleteButton {
        
        static let topOffset: CGFloat = 16
        static let leftOffset: CGFloat = 16
        static let rightOffset: CGFloat = 16
        static let height: CGFloat = 48
                
    }
    
}
