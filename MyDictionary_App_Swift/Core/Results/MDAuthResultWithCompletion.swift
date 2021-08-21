//
//  MDAuthResultWithCompletion.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.08.2021.
//

import Foundation

typealias MDAuthResultWithCompletion = ((Result<Void, Error>) -> Void)
