//
//  MDAppStyling.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import UIKit

struct MDAppStyling {
    
    enum Color {
        
        case md_FFFFFF
        case md_101010
        case md_3C3C3C
        case md_F8F8F8
        case md_007AFF
        case md_4400D4
        case md_5200FF
        case md_C7C7CC
        
        case md_F2F2F7
        case md_1C1C1E
        case md_48484A
        case md_0A84FF
        
        case md_C6C6C6
        
        
        /// - Parameter alpha: 1.0 by default
        func color(_ alpha: CGFloat = 1.0) -> UIColor {
            switch self {
            
            case .md_FFFFFF:
                return UIColor.init(rgb: 0xFFFFFF, alpha: alpha)
                
            case .md_101010:
                return UIColor.init(rgb: 0x101010, alpha: alpha)
                
            case .md_3C3C3C:
                return UIColor.init(rgb: 0x3C3C3C, alpha: alpha)
                
            case .md_F8F8F8:
                return UIColor.init(rgb: 0xF8F8F8, alpha: alpha)
                
            case .md_007AFF:
                return UIColor.init(rgb: 0x007AFF, alpha: alpha)
                
            case .md_4400D4:
                return UIColor.init(rgb: 0x4400D4, alpha: alpha)
                
            case .md_5200FF:
                return UIColor.init(rgb: 0x5200FF, alpha: alpha)
                
            case.md_C7C7CC:
                return UIColor.init(rgb: 0xC7C7CC, alpha: alpha)
                
                
            case .md_F2F2F7:
                return UIColor.init(rgb: 0xF2F2F7, alpha: alpha)
                
            case .md_1C1C1E:
                return UIColor.init(rgb: 0x1C1C1E, alpha: alpha)
                
            case .md_48484A:
                return UIColor.init(rgb: 0x48484A, alpha: alpha)
                
            case .md_0A84FF:
                return UIColor.init(rgb: 0x0A84FF, alpha: alpha)
                
                
            case .md_C6C6C6:
                return UIColor.init(rgb: 0xC6C6C6, alpha: alpha)
                
            }
        }
        
    }
    
    enum Font {
        
        case systemFont
        case boldSystemFont
        
        // MyriadPro
        case MyriadProBold
        case MyriadProSemiBold
        case MyriadProItalic
        case MyriadProRegular
        
        /// - Parameter ofSize: MDConstants.Font.defaultSize by default
        func font(ofSize size: CGFloat = MDConstants.Font.defaultSize) -> UIFont {
            switch self {
            case .systemFont:
                return .systemFont(ofSize: size)
            case .boldSystemFont:
                return .boldSystemFont(ofSize: size)
            case .MyriadProBold:
                return UIFont.init(name: "MyriadPro-Bold", size: size)!
            case .MyriadProSemiBold:
                return UIFont.init(name: "MyriadPro-Semibold", size: size)!
            case .MyriadProItalic:
                return UIFont.init(name: "MyriadPro-It", size: size)!
            case .MyriadProRegular:
                return UIFont.init(name: "MyriadPro-Regular", size: size)!
            }
        }
        
    }
    
    enum Image: String {
        
        case background_navigation_bar_0
        case background_typography_0
        case my_dictionary
        case background_typography_1
        case back_white_arrow
        case eye_closed
        case eye_open
        case background_typography_2
        case add
        case settings
        case background_navigation_bar_1
        case right_arrow
        case search
        case delete
        
        var image: UIImage {
            
            switch self {
            
            case .background_navigation_bar_0,
                 .background_typography_0,
                 .my_dictionary,
                 .background_typography_1,
                 .eye_open,
                 .eye_closed,
                 .back_white_arrow,
                 .background_typography_2,
                 .add,
                 .settings,
                 .background_navigation_bar_1,
                 .right_arrow,
                 .search,
                 .delete:
                
                return configuredImage(fromName: self.rawValue)
                
            }
            
        }
        
        private func configuredImage(fromName name: String) -> UIImage {
            return imageWithAlwaysOriginalMode(image(fromName: name))
        }
        
        private func image(fromName name: String) -> UIImage {
            guard let image = UIImage.init(named: name) else { fatalError("\(Self.self), \(#function), Cannot find image with name: \(name)") }
            return image
        }
        
        private func imageWithAlwaysOriginalMode(_ image: UIImage) -> UIImage {
            return image.withRenderingMode(.alwaysOriginal)
        }
        
    }
    
}
