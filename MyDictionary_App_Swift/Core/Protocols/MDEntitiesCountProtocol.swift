//
//  MDEntitiesCountProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 20.08.2021.
//

import Foundation

protocol MDEntitiesCountProtocol {
    func entitiesCount(_ completionHandler: @escaping (MDEntitiesCountResultWithCompletion))
}
