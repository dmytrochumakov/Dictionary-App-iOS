//
//  MDDeleteJWTProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

protocol MDDeleteJWTProtocol {
    func deleteJWT(_ jwtResponse: JWTResponse, _ completionHandler: @escaping(MDOperationResultWithCompletion<JWTResponse>))
    func deleteAllJWT(_ completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
}
