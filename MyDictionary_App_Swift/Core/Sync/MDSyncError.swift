//
//  MDSyncError.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 02.09.2021.
//

import Foundation

enum MDSyncError: Error {
    case syncIsRunning
}

extension MDSyncError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .syncIsRunning:
            return "Sorry. Syncing is already in progress."
        }
    }
    
}
