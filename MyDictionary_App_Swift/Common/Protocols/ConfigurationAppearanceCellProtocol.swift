//
//  ConfigurationAppearanceCellProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 06.06.2021.
//

import UIKit

protocol ConfigurationAppearanceCellProtocol: ConfigureAppearanceCellViewBackgroundColor,
                                              ConfigureAppearanceCellLabelTextColor {
    
    
}

struct ConfigurationAppearanceCellModel: ConfigurationAppearanceCellProtocol {
    
    var cellViewBackgroundColor: UIColor
    var labelTextColor: UIColor
    
    init(appearanceType: AppearanceType) {
        self.cellViewBackgroundColor = AppStyling.cellBackgroundColor(fromAppearanceType: appearanceType)
        self.labelTextColor = AppStyling.labelTextColor(fromAppearanceType: appearanceType)
    }
    
}
