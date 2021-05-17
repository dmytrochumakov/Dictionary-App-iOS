//
//  ReuseIdentifierProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 17.05.2021.
//

import Foundation

protocol ReuseIdentifierProtocol {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifierProtocol {
    
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
    
}
