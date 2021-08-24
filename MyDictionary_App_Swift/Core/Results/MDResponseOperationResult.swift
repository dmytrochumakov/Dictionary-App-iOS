//
//  MDResponseOperationResult.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.07.2021.
//

import Foundation

enum MDResponseOperationResult {
    case data(_ : Data?, _ : HTTPURLResponse?)
    case error(_ : Error, _ : HTTPURLResponse?)
}
