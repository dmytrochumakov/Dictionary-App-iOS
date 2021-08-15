//
//  MDDeleteJWTProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

protocol MDDeleteJWTProtocol {
    func deleteJWT(_ authResponse: AuthResponse, _ completionHandler: @escaping(MDEntityResult<AuthResponse>))
}
