//
//  MDEditWordViewControllerConfiguration.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.09.2021.
//

import UIKit

struct MDEditWordViewControllerConfiguration {
    
    struct EditWordButton {
        
        static let rightOffset: CGFloat = 8
        static let size: CGSize = .init(width: 40, height: 40)
        static let image: UIImage = MDUIResources.Image.edit.image
        
    }
    
    struct WordTextField {
        
        static func topOffset(fromNavigationController navigationController: UINavigationController?) -> CGFloat {
            return MDConstants.NavigationBar.height(fromNavigationController: navigationController, prefersLargeTitles: false) + 24
        }
        static let leftOffset: CGFloat = 16
        static let rightOffset: CGFloat = 16
        static let height: CGFloat = 48
        
    }
    
    struct WordDescriptionTextView {
        
        static func inactiveEditModeTopOffset(fromNavigationController navigationController: UINavigationController?) -> CGFloat {
            return WordTextField.topOffset(fromNavigationController: navigationController) + WordTextField.height + 16
        }
        static func activeEditModeTopOffset(fromNavigationController navigationController: UINavigationController?) -> CGFloat {
            return WordTextField.topOffset(fromNavigationController: navigationController)
        }
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
