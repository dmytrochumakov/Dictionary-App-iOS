//
//  Encodable+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.08.2021.
//

import Foundation

extension Encodable {
    
    var data: Data {
        do {
            return try JSONEncoder.init().encode(self)
        } catch {
            fatalError("Impossible Try Encode Data")
        }
    }
    
}
