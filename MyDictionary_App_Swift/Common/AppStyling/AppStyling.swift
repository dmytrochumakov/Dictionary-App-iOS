//
//  AppStyling.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import UIKit

struct AppStyling {
    
    enum Color {
        
        case systemBlack
        case systemWhite
        case lightGray
        case darkGray
        case systemGray
        
        /// - Parameter alpha: 1.0 by default
        func color(_ alpha: CGFloat = 1.0) -> UIColor {
            switch self {
            case .lightGray:
                return UIColor.lightGray.withAlphaComponent(alpha)
            case .darkGray:
                return UIColor.darkGray.withAlphaComponent(alpha)
            case .systemBlack:
                return UIColor.black.withAlphaComponent(alpha)
            case .systemWhite:
                return UIColor.white.withAlphaComponent(alpha)
            case .systemGray:
                return UIColor.systemGray.withAlphaComponent(alpha)
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
        
    }
    
}
