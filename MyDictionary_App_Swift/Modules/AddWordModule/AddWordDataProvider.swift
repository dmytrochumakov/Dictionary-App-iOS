//
//  AddWordDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 27.09.2021.

import Foundation

protocol AddWordDataProviderProtocol {
    var wordText: String? { get set }
    var wordDescription: String? { get set }
}

final class AddWordDataProvider: AddWordDataProviderProtocol {
    
    var wordText: String?
    var wordDescription: String?
    
}
