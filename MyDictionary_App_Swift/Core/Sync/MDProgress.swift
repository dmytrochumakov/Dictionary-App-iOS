//
//  MDProgress.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 02.09.2021.
//

import Foundation

typealias MDProgressWithCompletion = ((MDProgressWithoutCompletion) -> Void)
typealias MDProgressWithoutCompletion = (Float)
