//
//  Appearance.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 05.06.2021.
//

import Foundation

struct Appearance {
    
    static let current: Appearance = .init()
    
    /// Default is .automatic
    var appearanceType: AppearanceType = .automatic
    
}
