//
//  CDResultSavedEnum.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import Foundation

public enum CDResultSavedEnum<Failure> where Failure : Error {
    case success
    case failure(Failure)
}
