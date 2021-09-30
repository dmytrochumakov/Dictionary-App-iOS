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
        
        static func isHidden(editButtonIsSelected isSelected: Bool) -> Bool {
            return isSelected
        }
        
    }
    
    struct WordTextField {
        
        static let leftOffset: CGFloat = 16
        static let rightOffset: CGFloat = 16
        static let height: CGFloat = 48
        
        static func topOffset(fromNavigationController navigationController: UINavigationController?) -> CGFloat {
            return MDConstants.NavigationBar.height(fromNavigationController: navigationController, prefersLargeTitles: false) + 24
        }
        
        static func isHidden(editButtonIsSelected isSelected: Bool) -> Bool {
            return !isSelected
        }
        
    }
    
    struct WordDescriptionTextView {
        
        static let leftOffset: CGFloat = 16
        static let rightOffset: CGFloat = 16
        static let height: CGFloat = 290
        
        static func topOffset(editButtonIsSelected isSelected: Bool,
                              navigationController: UINavigationController?) -> CGFloat {
            if (isSelected) {
                return activeEditModeTopOffset(fromNavigationController: navigationController)
            } else {
                return inactiveEditModeTopOffset(fromNavigationController: navigationController)
            }
        }
        
        static func isEditable(editButtonIsSelected isSelected: Bool) -> Bool {
            return isSelected
        }
        
        fileprivate static func inactiveEditModeTopOffset(fromNavigationController navigationController: UINavigationController?) -> CGFloat {
            return WordTextField.topOffset(fromNavigationController: navigationController)
        }
        
        fileprivate static func activeEditModeTopOffset(fromNavigationController navigationController: UINavigationController?) -> CGFloat {
            return WordTextField.topOffset(fromNavigationController: navigationController) + WordTextField.height + 16
        }
        
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
        
        static func isHidden(editButtonIsSelected isSelected: Bool) -> Bool {
            return !isSelected
        }
        
    }
    
    struct DeleteButton {
        
        static let topOffset: CGFloat = 16
        static let leftOffset: CGFloat = 16
        static let rightOffset: CGFloat = 16
        static let height: CGFloat = 48
        
        static func isHidden(editButtonIsSelected isSelected: Bool) -> Bool {
            return !isSelected
        }
        
    }
    
}
