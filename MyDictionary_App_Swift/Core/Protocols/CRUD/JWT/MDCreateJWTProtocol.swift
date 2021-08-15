//
//  MDCreateJWTProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

protocol MDCreateJWTProtocol {
    func createJWT(_ authResponse: AuthResponse, _ completionHandler: @escaping(MDEntityResult<AuthResponse>))
}
