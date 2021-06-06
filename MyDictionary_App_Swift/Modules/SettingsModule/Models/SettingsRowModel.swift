//
//  SettingsRowModel.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 31.05.2021.
//

import Foundation

struct SettingsRowModel: AppearanceTypePropertyProtocol {
    let rowType: SettingsRowType
    let titleText: String
    var appearanceType: AppearanceType
}
