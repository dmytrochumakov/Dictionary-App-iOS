//
//  MDUsersCountProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

protocol MDUsersCountProtocol {
    func usersCount(_ completionHandler: @escaping (MDEntityCountResult))
}
