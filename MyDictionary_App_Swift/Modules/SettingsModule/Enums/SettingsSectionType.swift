//
//  SettingsSectionType.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 31.05.2021.
//

import Foundation

enum SettingsSectionType: Int {
    case list
}

// MARK: - SectionTypeProtocol
extension SettingsSectionType: SectionTypeProtocol {
    
    typealias SectionType = Self
    
    static func type(rawValue: Int) -> SettingsSectionType {
        guard let type = SettingsSectionType.init(rawValue: rawValue) else { fatalError("Impossible Cast rawValue to " + String(describing: Self.self)) }
        return type
    }
    
    static func type(atIndexPath indexPath: IndexPath) -> SettingsSectionType {
        return self.type(rawValue: indexPath.section)
    }
    
    static func type(atSection section: Int) -> SettingsSectionType {
        return self.type(rawValue: section)
    }
    
}
