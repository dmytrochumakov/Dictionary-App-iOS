//
//  MDReadJWTProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

protocol MDReadJWTProtocol {
    func readJWT(fromAccessToken accessToken: String, _ completionHandler: @escaping(MDEntityResult<AuthResponse>))
}
