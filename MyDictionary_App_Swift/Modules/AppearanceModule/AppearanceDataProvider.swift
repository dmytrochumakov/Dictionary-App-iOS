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
    
    init() {
        self.rows = Self.configuredRows
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
    
    static var configuredRows: [AppearanceRowModel] {
        var rows: [AppearanceRowModel] = []
        AppearanceRowType.allCases.forEach { rowType in
            switch rowType {
            case .automatic:
                rows.append(.init(titleText: KeysForTranslate.automatic.localized,
                                  rowType: rowType,
                                  isSelected: true))
            case .light:
                rows.append(.init(titleText: KeysForTranslate.light.localized,
                                  rowType: rowType,
                                  isSelected: false))
            case .dark:
                rows.append(.init(titleText: KeysForTranslate.dark.localized,
                                  rowType: rowType,
                                  isSelected: false))
            }
            
        }
        return rows
    }
    
}
