//
//  AppearanceDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 03.06.2021.

import Foundation

protocol AppearanceDataManagerInputProtocol {
    var dataProvider: AppearanceDataProviderProtocol { get }
    func didSelectItemAtIndexPath(_ indexPath: IndexPath)
    func appearanceType(atIndexPath indexPath: IndexPath) -> AppearanceType
}

protocol AppearanceDataManagerOutputProtocol: AnyObject {
    func rowsForUpdate(_ rows: [IndexPath : AppearanceRowModel])
}

protocol AppearanceDataManagerProtocol: AppearanceDataManagerInputProtocol {
    var dataManagerOutput: AppearanceDataManagerOutputProtocol? { get set }
}

final class AppearanceDataManager: AppearanceDataManagerProtocol {
    
    internal let dataProvider: AppearanceDataProviderProtocol
    internal weak var dataManagerOutput: AppearanceDataManagerOutputProtocol?
    
    init(dataProvider: AppearanceDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension AppearanceDataManager {
    
    func didSelectItemAtIndexPath(_ indexPath: IndexPath) {
        var rowsForUpdate: [IndexPath : AppearanceRowModel] = [:]
        dataProvider.rows.forEach { row in
            rowsForUpdate.updateValue(.init(titleText: row.titleText,
                                            rowType: row.rowType,
                                            isSelected: indexPath.row == row.rowType.rawValue,
                                            appearanceType: appearanceType(atIndexPath: indexPath)),
                                      forKey: .init(item: row.rowType.rawValue,
                                                    section: .zero))
        }
        dataManagerOutput?.rowsForUpdate(rowsForUpdate)
    }
    
}

extension AppearanceDataManager {
    
    func appearanceType(atIndexPath indexPath: IndexPath) -> AppearanceType {
        return Self.appearanceType(fromAppearanceRowType: dataProvider.row(atIndexPath: indexPath).rowType)
    }
    
    static func appearanceType(fromAppearanceRowType type: AppearanceRowType) -> AppearanceType {
        switch type {
        case .automatic:
            return .automatic
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
    
}
