//
//  MDSettingsError.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.09.2021.
//

import Foundation

enum MDSettingsError: Error {
    case mailServicesAreNotAvailable
}

extension MDSettingsError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .mailServicesAreNotAvailable:
            return LocalizedText.mailServicesAreNotAvailable.localized
        }
    }
    
}
