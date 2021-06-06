//
//  ConfigureAppearanceCellLabelTextColor.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 06.06.2021.
//

import UIKit

protocol ConfigureAppearanceCellLabelTextColor {
    static func labelTextColor(fromAppearanceType type: AppearanceType) -> UIColor
}
