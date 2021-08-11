//
//  ConfigurationAppearanceControllerProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 06.06.2021.
//

import UIKit

protocol ConfigureAppearanceViewBackgroundColor {
    static func viewBackgroundColor(fromAppearanceType type: AppearanceType) -> UIColor
}

protocol ConfigureAppearanceNavigationBarTintColor {
    static func navigationBarTintColor(fromAppearanceType type: AppearanceType) -> UIColor
}

protocol ConfigureAppearanceNavigationBarProtocol: ConfigureAppearanceNavigationBarTintColor {
    static func navigationBarTitleTextAttributes(fromAppearanceType type: AppearanceType) -> [NSAttributedString.Key : Any]
}

protocol ConfigurationAppearanceControllerProtocol: ConfigureAppearanceViewBackgroundColor,
                                                    ConfigureAppearanceNavigationBarProtocol {
    
}

struct ConfigurationAppearanceController: ConfigurationAppearanceControllerProtocol {
    
}

// MARK: - Configured
extension ConfigurationAppearanceController {
    
    /// - Parameter fromAppearanceType type: Appearance.current.appearanceType by default
    static func viewBackgroundColor(fromAppearanceType type: AppearanceType = Appearance.current.appearanceType) -> UIColor {
        switch type {
        case .automatic:
            return self.viewBackgroundColor(fromAppearanceType: .light)
        case .light:
            return AppStyling.Color.lightGray.color()
        case .dark:
            return AppStyling.Color.darkGray.color()
        }
    }
    
    /// - Parameter fromAppearanceType type: Appearance.current.appearanceType by default
    static func navigationBarTitleTextAttributes(fromAppearanceType type: AppearanceType = Appearance.current.appearanceType) -> [NSAttributedString.Key : Any] {
        switch type {
        case .automatic:
            return self.navigationBarTitleTextAttributes(fromAppearanceType: .light)
        case .light, .dark:
            return self.navigationBarAttributedStringForegroundColor(fromAppearanceType: type)
        }
    }
    
    fileprivate static func navigationBarAttributedStringForegroundColor(fromAppearanceType type: AppearanceType) -> [NSAttributedString.Key : Any] {
        switch type {
        case .light:
            return [NSAttributedString.Key.foregroundColor : AppStyling.Color.systemBlack.color()]
        case .dark:
            return [NSAttributedString.Key.foregroundColor : AppStyling.Color.systemWhite.color()]
        default:
            return Self.navigationBarAttributedStringForegroundColor(fromAppearanceType: .light)
        }
    }
    
    /// - Parameter fromAppearanceType type: Appearance.current.appearanceType by default
    static func navigationBarTintColor(fromAppearanceType type: AppearanceType = Appearance.current.appearanceType) -> UIColor {
        switch type {
        case .automatic:
            return self.navigationBarTintColor(fromAppearanceType: .light)
        case .light:
            return AppStyling.Color.systemWhite.color()
        case .dark:
            return AppStyling.Color.darkGray.color()
        }
    }      
    
}
