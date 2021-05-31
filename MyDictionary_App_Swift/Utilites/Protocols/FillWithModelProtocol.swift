//
//  FillWithModelProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 31.05.2021.
//

import Foundation

protocol FillWithModelProtocol {
    associatedtype Model
    func fillWithModel(_ model: Model)
}
