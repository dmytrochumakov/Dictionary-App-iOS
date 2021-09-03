//
//  MDUpdateJWTProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

protocol MDUpdateJWTProtocol {
    func updateJWT(oldAccessToken accessToken: String,
                   newJWTResponse jwtResponse: JWTResponse,
                   _ completionHandler: @escaping(MDOperationResultWithCompletion<JWTResponse>))
}
