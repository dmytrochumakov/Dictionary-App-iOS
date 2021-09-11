//
//  MDAppStyling.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import UIKit

struct MDAppStyling {
    
    enum Color {
        
        // Light
        case md_White_0_Light_Appearence
        case md_Black_0_Light_Appearence
        case md_Light_Gray_0_Light_Appearence
        case md_Blue_0_Light_Appearence
        case md_Blue_1_Light_Appearence        
        
        // Dark
        case md_White_0_Dark_Appearence
        case md_Black_0_Dark_Appearence
        case md_Light_Gray_0_Dark_Appearence
        case md_Blue_0_Dark_Appearence
        
        // Other
        case light_Gray_0
        
        
        /// - Parameter alpha: 1.0 by default
        func color(_ alpha: CGFloat = 1.0) -> UIColor {
            switch self {
            
            // Light
            case .md_White_0_Light_Appearence:
                return UIColor.init(rgb: 0xFFFFFF, alpha: alpha)
                
            case .md_Black_0_Light_Appearence:
                return UIColor.init(rgb: 0x101010, alpha: alpha)
                
            case .md_Light_Gray_0_Light_Appearence:
                return UIColor.init(rgb: 0xF8F8F8, alpha: alpha)
                
            case .md_Blue_0_Light_Appearence:
                return UIColor.init(rgb: 0x007AFF, alpha: alpha)
                
            case .md_Blue_1_Light_Appearence:
                return UIColor.init(rgb: 0x4400D4, alpha: alpha)
                
            // Dark
            case .md_White_0_Dark_Appearence:
                return UIColor.init(rgb: 0xF2F2F7, alpha: alpha)
                
            case .md_Black_0_Dark_Appearence:
                return UIColor.init(rgb: 0x1C1C1E, alpha: alpha)
                
            case .md_Light_Gray_0_Dark_Appearence:
                return UIColor.init(rgb: 0x48484A, alpha: alpha)
                
            case .md_Blue_0_Dark_Appearence:
                return UIColor.init(rgb: 0x0A84FF, alpha: alpha)
                
            case .light_Gray_0:
                return UIColor.init(rgb: 0xC6C6C6, alpha: alpha)
                
            }
        }
        
    }
    
    enum Font {
        
        case systemFont
        case boldSystemFont
        
        /// - Parameter ofSize: 14.0 by default
        func font(ofSize size: CGFloat = 14.0) -> UIFont {
            switch self {
            case .systemFont:
                return .systemFont(ofSize: size)
            case .boldSystemFont:
                return .boldSystemFont(ofSize: size)
            }
        }
        
        /// Font: systemFont by default
        /// Font size: 17.0 by default
        static var `default`: UIFont {
            return Font.systemFont.font(ofSize: 17)
        }
        
    }
    
    enum Image: String {
        
        case background_navigation_bar_0
        case background_typography_0
        case my_dictionary
        
        var image: UIImage {
            
            switch self {
            
            case .background_navigation_bar_0,
                 .background_typography_0,
                 .my_dictionary:
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
