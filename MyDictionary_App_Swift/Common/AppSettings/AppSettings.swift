//
//  AppSettings.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 26.08.2021.
//

import Foundation

protocol AppSettingsProtocol {
    var isLoggedIn: Bool { get }
    func setIsLoggedIn(_ newValue: Bool)
}

final class AppSettings: AppSettingsProtocol {
        
    fileprivate let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
}

extension AppSettings {
    
    var isLoggedIn: Bool {
        return userDefaults.bool(forKey: #function)
    }
    
    func setIsLoggedIn(_ newValue: Bool) {
        userDefaults.set(newValue, forKey: #function)
    }
    
}
