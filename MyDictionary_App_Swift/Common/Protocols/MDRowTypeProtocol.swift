//
//  MDRowTypeProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 17.05.2021.
//

import Foundation

protocol MDRowTypeProtocol {
    associatedtype RowType
    static func type(rawValue: Int) -> RowType
    static func type(atIndexPath indexPath: IndexPath) -> RowType
}
