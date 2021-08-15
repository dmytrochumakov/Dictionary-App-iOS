//
//  MDReadUserProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

protocol MDReadUserProtocol {
    func readUser(fromID id: Int64, _ completionHandler: @escaping(MDUserResult))
}
