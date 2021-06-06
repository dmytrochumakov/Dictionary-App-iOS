//
//  SettingsDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 31.05.2021.

import Foundation

protocol SettingsDataProviderProtocol: NumberOfSectionsProtocol,
                                       NumberOfRowsInSectionProtocol {
    func rows(atSection section: Int) -> [SettingsRowModel]
    func rowModel(atIndexPath indexPath: IndexPath) -> SettingsRowModel
}

final class SettingsDataProvider: SettingsDataProviderProtocol {
    
    fileprivate let model: SettingsDataProviderModel
    
    init(model: SettingsDataProviderModel) {
        self.model = model
    }
    
}

extension SettingsDataProvider {
    
    var numberOfSections: Int {
        return model.sections.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return model.sections[section].rows.count
    }
    
}

extension SettingsDataProvider {
    
    func rowModel(atIndexPath indexPath: IndexPath) -> SettingsRowModel {
        return model.sections[indexPath.section].rows[indexPath.row]        
    }
    
    func rows(atSection section: Int) -> [SettingsRowModel] {
        return model.sections[section].rows
    }
    
}
