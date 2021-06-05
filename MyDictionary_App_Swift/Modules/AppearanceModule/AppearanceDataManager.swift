//
//  AppearanceDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 03.06.2021.

import Foundation

protocol AppearanceDataManagerInputProtocol {
    func didSelectItemAtIndexPath(_ indexPath: IndexPath)
}

protocol AppearanceDataManagerOutputProtocol: AnyObject {
    func rowsForUpdate(_ rows: [IndexPath : AppearanceRowModel])
}

protocol AppearanceDataManagerProtocol: AppearanceDataManagerInputProtocol {
    var dataProvider: AppearanceDataProviderProtocol { get }
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
                                            isSelected: indexPath.row == row.rowType.rawValue),
                                      forKey: .init(item: row.rowType.rawValue,
                                                    section: .zero))
        }
        dataManagerOutput?.rowsForUpdate(rowsForUpdate)
    }
    
}
