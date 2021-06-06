//
//  AppearanceRowType.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 05.06.2021.
//

import Foundation

enum AppearanceRowType: Int, CaseIterable {
    case automatic
    case light
    case dark
}

// MARK: - RowTypeProtocol
extension AppearanceRowType: RowTypeProtocol {
    
    typealias RowType = Self
    
    static func type(rawValue: Int) -> AppearanceRowType {
        guard let type = AppearanceRowType.init(rawValue: rawValue) else { fatalError("Impossible Cast rawValue to " + String(describing: Self.self)) }
        return type
    }
    
    static func type(atIndexPath indexPath: IndexPath) -> AppearanceRowType {
        return self.type(rawValue: indexPath.row)
    }
    
}

extension AppearanceRowType {
    
    var appearanceType: AppearanceType {
        switch self {
        case .automatic:
            return .automatic
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
    
}
