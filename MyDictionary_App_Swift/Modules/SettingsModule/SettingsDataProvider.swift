//
//  SettingsDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 31.05.2021.

import Foundation

protocol SettingsDataProviderProtocol: NumberOfSectionsProtocol,
                                       NumberOfRowsInSectionProtocol {
    
    func rowModel(atIndexPath indexPath: IndexPath) -> SettingsRowModel
}

final class SettingsDataProvider: SettingsDataProviderProtocol {
    
    fileprivate let rows: [SettingsRowModel]
    
    init(rows: [SettingsRowModel]) {
        self.rows = rows
    }
    
}

extension SettingsDataProvider {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return rows.count
    }
    
}

extension SettingsDataProvider {
    
    func rowModel(atIndexPath indexPath: IndexPath) -> SettingsRowModel {
        return rows[indexPath.row]
    }
    
}
