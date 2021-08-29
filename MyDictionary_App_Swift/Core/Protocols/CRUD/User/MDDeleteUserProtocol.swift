//
//  MDDeleteUserProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

protocol MDDeleteUserProtocol {
    func deleteUser(_ userEntity: UserResponse, _ completionHandler: @escaping(MDEntityResult<UserResponse>))
}
