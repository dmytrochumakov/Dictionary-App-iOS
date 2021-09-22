//
//  AppearanceDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 03.06.2021.

import Foundation

protocol AppearanceDataProviderProtocol: NumberOfSectionsProtocol,
                                         NumberOfRowsInSectionProtocol {
    var rows: [AppearanceRowModel] { get }
    func row(atIndexPath indexPath: IndexPath) -> AppearanceRowModel
}

final class AppearanceDataProvider: AppearanceDataProviderProtocol {
    
    internal let rows: [AppearanceRowModel]
    
    init(appearanceType: AppearanceType) {
        self.rows = Self.configuredRows(fromAppearanceType: appearanceType)
    }
    
}

extension AppearanceDataProvider {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return rows.count
    }
    
}

extension AppearanceDataProvider {
    
    func row(atIndexPath indexPath: IndexPath) -> AppearanceRowModel {
        return rows[indexPath.row]
    }
    
}

fileprivate extension AppearanceDataProvider {
    
    static func configuredRows(fromAppearanceType appearanceType: AppearanceType) -> [AppearanceRowModel] {
        var rows: [AppearanceRowModel] = []
        AppearanceRowType.allCases.forEach { rowType in
            rows.append(.init(titleText: Self.configuredTitleText(rowType: rowType),
                              rowType: rowType,
                              isSelected: Self.appearanceRowType(fromAppearanceType: appearanceType) == rowType,
                              appearanceType: appearanceType))
            
        }
        return rows
    }
    
    static func configuredTitleText(rowType: AppearanceRowType) -> String {
        switch rowType {
        case .automatic:
            return LocalizedText.automatic.localized
        case .light:
            return LocalizedText.light.localized
        case .dark:
            return LocalizedText.dark.localized
        }
    }
    
    static func appearanceRowType(fromAppearanceType appearanceType: AppearanceType) -> AppearanceRowType{
        switch appearanceType {
        case .automatic:
            return .automatic
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
    
}
