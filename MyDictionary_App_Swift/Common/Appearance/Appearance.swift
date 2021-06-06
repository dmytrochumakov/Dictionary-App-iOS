//
//  Appearance.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 05.06.2021.
//

import Foundation

final class Appearance: NSObject {
    
    /// Default is .automatic
    fileprivate var internalAppearanceType: AppearanceType
    internal var appearanceType: AppearanceType {
        return internalAppearanceType
    }
    /// Default is equal internalAppearanceType
    internal var didChangeAppearanceObservable: Observable<AppearanceType>
    
    static let current: Appearance = .init()
    
    fileprivate override init() {
        self.internalAppearanceType = Self.getSavedAppearanceType()
        self.didChangeAppearanceObservable = .init(value: self.internalAppearanceType)
    }
    
    deinit {
        didChangeAppearanceObservable.removeObserver(self)
    }
    
}

// MARK: - Update Appearance
extension Appearance {
    
    func updateAppearance(_ newValue: AppearanceType) {
        Self.saveAppearanceType(newValue)
        self.internalAppearanceType = newValue
        self.didChangeAppearanceObservable.updateValue(newValue)
    }
    
}

fileprivate extension Appearance {
    
    struct Constants {
        static let appearanceTypeKey: String = "Appearance_Type_Key"
    }
    
    static func getSavedAppearanceType() -> AppearanceType {
        guard let appearanceType: AppearanceType = .init(rawValue: UserDefaults.standard.integer(forKey: Constants.appearanceTypeKey)) else { return .automatic }
        return appearanceType
    }
    
    static func saveAppearanceType(_ appearanceType: AppearanceType) {
        UserDefaults.standard.setValue(appearanceType.rawValue,
                                       forKey: Constants.appearanceTypeKey)
    }
    
}
