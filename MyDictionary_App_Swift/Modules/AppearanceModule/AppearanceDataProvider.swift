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
        let configurationAppearanceCell = ConfigurationAppearanceCellModel.init(appearanceType: appearanceType)
        var rows: [AppearanceRowModel] = []
        AppearanceRowType.allCases.forEach { rowType in
            switch rowType {
            case .automatic:
                rows.append(.init(titleText: KeysForTranslate.automatic.localized,
                                  rowType: rowType,
                                  isSelected: true,
                                  configurationAppearanceCell: configurationAppearanceCell))
            case .light:
                rows.append(.init(titleText: KeysForTranslate.light.localized,
                                  rowType: rowType,
                                  isSelected: false,
                                  configurationAppearanceCell: configurationAppearanceCell))
            case .dark:
                rows.append(.init(titleText: KeysForTranslate.dark.localized,
                                  rowType: rowType,
                                  isSelected: false,
                                  configurationAppearanceCell: configurationAppearanceCell))
            }
            
        }
        return rows
    }
    
}
