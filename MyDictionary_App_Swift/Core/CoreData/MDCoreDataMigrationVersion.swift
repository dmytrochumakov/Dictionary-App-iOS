//
//  MDCoreDataMigrationVersion.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 07.11.2021.
//

import Foundation

enum MDCoreDataMigrationVersion: Int, CaseIterable {
    
    case version1 = 1
    case version2
    
    var stringVersion: String {
        if rawValue == 1 {
            return MDConstants.StaticText.appName
        } else {
            return "\(MDConstants.StaticText.appName) \(rawValue)"
        }
    }
    
    static var current: MDCoreDataMigrationVersion {
        guard let current = allCases.last else {
            fatalError("no model versions found")
        }
        return current
    }
    
    func nextVersion() -> MDCoreDataMigrationVersion? {
        switch self {
        case .version1:
            return .version2
        case .version2:
            return nil
        }
    }
    
}
