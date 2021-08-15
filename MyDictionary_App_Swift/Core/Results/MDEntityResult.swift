//
//  MDEntityResult.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

typealias MDEntityResult<Entity> = ((Result<Entity, Error>) -> Void)
