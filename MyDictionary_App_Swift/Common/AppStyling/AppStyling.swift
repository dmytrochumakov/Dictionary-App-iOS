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
        case systemGray2
        case systemGray3
        case systemGray4
        case systemGray5
        case systemGray6
        
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
            case .systemGray2:
                return UIColor.systemGray2.withAlphaComponent(alpha)
            case .systemGray3:
                return UIColor.systemGray3.withAlphaComponent(alpha)
            case .systemGray4:
                return UIColor.systemGray4.withAlphaComponent(alpha)
            case .systemGray5:
                return UIColor.systemGray5.withAlphaComponent(alpha)
            case .systemGray6:
                return UIColor.systemGray6.withAlphaComponent(alpha)
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

extension AppStyling {
    
    /// - Parameter fromAppearanceType type: Appearance.current.appearanceType by default
    static func labelTextColor(fromAppearanceType type: AppearanceType = Appearance.current.appearanceType) -> UIColor {
        switch type {
        case .automatic:
            switch Self.automaticAppearanceType(fromUserInterfaceStyle: UITraitCollection.current.userInterfaceStyle) {
            case .dark:
                return self.labelTextColor(fromAppearanceType: .dark)
            default:
                return self.labelTextColor(fromAppearanceType: .light)
            }
        case .light:
            return Color.systemBlack.color()
        case .dark:
            return Color.systemWhite.color()
        }
    }
    
}

extension AppStyling {
    
    /// - Parameter fromAppearanceType type: Appearance.current.appearanceType by default
    static func viewBackgroundColor(fromAppearanceType type: AppearanceType = Appearance.current.appearanceType) -> UIColor {
        switch type {
        case .automatic:
            switch Self.automaticAppearanceType(fromUserInterfaceStyle: UITraitCollection.current.userInterfaceStyle) {
            case .dark:
                return self.viewBackgroundColor(fromAppearanceType: .dark)
            default:
                return self.viewBackgroundColor(fromAppearanceType: .light)
            }
        case .light:
            return Color.lightGray.color()
        case .dark:
            return Color.darkGray.color()
        }
    }
    
    /// - Parameter fromAppearanceType type: Appearance.current.appearanceType by default
    static func cellBackgroundColor(fromAppearanceType type: AppearanceType = Appearance.current.appearanceType) -> UIColor {
        switch type {
        case .automatic:
            switch Self.automaticAppearanceType(fromUserInterfaceStyle: UITraitCollection.current.userInterfaceStyle) {
            case .dark:
                return self.cellBackgroundColor(fromAppearanceType: .dark)
            default:
                return self.cellBackgroundColor(fromAppearanceType: .light)
            }
        case .light:
            return Color.systemWhite.color()
        case .dark:
            return Color.systemGray.color()
        }
    }
    
}

fileprivate extension AppStyling {
    
    static func automaticAppearanceType(fromUserInterfaceStyle userInterfaceStyle: UIUserInterfaceStyle) -> AppearanceType {
        switch userInterfaceStyle {
        case .light:
            return .light
        case .dark:
            return .dark
        default:
            return .light
        }
    }
    
}
