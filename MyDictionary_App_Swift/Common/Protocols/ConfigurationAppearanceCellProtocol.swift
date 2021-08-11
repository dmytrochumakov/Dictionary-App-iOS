//
//  ConfigurationAppearanceCellProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 06.06.2021.
//

import UIKit

protocol ConfigurationAppearanceCellProtocol: ConfigureAppearanceViewBackgroundColor,
                                              ConfigureAppearanceCellLabelTextColor {
    
    
}

struct ConfigurationAppearanceCell: ConfigurationAppearanceCellProtocol {
    
    
}

// MARK: - Configured
extension ConfigurationAppearanceCell {
    
    /// - Parameter fromAppearanceType type: Appearance.current.appearanceType by default
    static func viewBackgroundColor(fromAppearanceType type: AppearanceType = Appearance.current.appearanceType) -> UIColor {
        switch type {
        case .automatic:
            return self.viewBackgroundColor(fromAppearanceType: .light)
        case .light:
            return AppStyling.Color.md_White_0_Light_Appearence.color()
        case .dark:
            return AppStyling.Color.md_Black_0_Dark_Appearence.color()
        }
    }
    
    /// - Parameter fromAppearanceType type: Appearance.current.appearanceType by default
    static func labelTextColor(fromAppearanceType type: AppearanceType = Appearance.current.appearanceType) -> UIColor {
        switch type {
        case .automatic:
            return self.labelTextColor(fromAppearanceType: .light)            
        case .light:
            return AppStyling.Color.md_Black_0_Light_Appearence.color()
        case .dark:
            return AppStyling.Color.md_White_0_Dark_Appearence.color()
        }
    }
    
}
