//
//  SectionTypeProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 17.05.2021.
//

import Foundation

protocol SectionTypeProtocol {
    associatedtype SectionType
    static func type(rawValue: Int) -> SectionType
    static func type(atIndexPath indexPath: IndexPath) -> SectionType
    static func type(atSection section: Int) -> SectionType
}
