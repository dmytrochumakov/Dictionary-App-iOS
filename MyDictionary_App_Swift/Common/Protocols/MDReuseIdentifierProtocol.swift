//
//  MDReuseIdentifierProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 17.05.2021.
//

import Foundation

protocol MDReuseIdentifierProtocol {
    static var reuseIdentifier: String { get }
}

extension MDReuseIdentifierProtocol {
    
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
    
}
