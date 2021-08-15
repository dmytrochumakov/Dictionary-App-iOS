//
//  MDEntitiesResult.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import Foundation

typealias MDEntitiesResult<Entity> = ((Result<[Entity], Error>) -> Void)
