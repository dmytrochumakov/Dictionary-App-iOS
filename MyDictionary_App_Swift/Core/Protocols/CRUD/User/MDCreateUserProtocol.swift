//
//  MDCreateUserProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

protocol MDCreateUserProtocol {
    func createUser(_ userEntity: UserResponse,
                    password: String,
                    _ completionHandler: @escaping(MDEntityResult<UserResponse>))
}
