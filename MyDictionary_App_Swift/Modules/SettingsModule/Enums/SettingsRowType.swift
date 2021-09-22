//
//  SettingsRowType.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 31.05.2021.
//

import Foundation

enum SettingsRowType: Int {
    case about
    case account
    case privacyPolicy
    case termsOfService
    case support
}

extension SettingsRowType: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .about:
            return LocalizedText.about.localized
        case .account:
            return LocalizedText.account.localized
        case .privacyPolicy:
            return LocalizedText.privacyPolicy.localized
        case .termsOfService:
            return LocalizedText.termsOfService.localized
        case .support:
            return LocalizedText.support.localized
        }
    }
    
}

// MARK: - RowTypeProtocol
extension SettingsRowType: RowTypeProtocol {
    
    typealias RowType = Self
    
    static func type(rawValue: Int) -> SettingsRowType {
        guard let type = SettingsRowType.init(rawValue: rawValue) else { fatalError("Impossible Cast rawValue to " + String(describing: Self.self)) }
        return type
    }
    
    static func type(atIndexPath indexPath: IndexPath) -> SettingsRowType {
        return self.type(rawValue: indexPath.row)
    }
    
}
