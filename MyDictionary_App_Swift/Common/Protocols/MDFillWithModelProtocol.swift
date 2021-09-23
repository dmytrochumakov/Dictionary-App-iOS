//
//  MDFillWithModelProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 31.05.2021.
//

import Foundation

protocol MDFillWithModelProtocol {
    associatedtype Model
    func fillWithModel(_ model: Model)
}
