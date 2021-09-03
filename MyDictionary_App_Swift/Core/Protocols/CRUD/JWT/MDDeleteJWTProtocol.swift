//
//  MDDeleteJWTProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

protocol MDDeleteJWTProtocol {
    func deleteJWT(_ byAccessToken: String, _ completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
    func deleteAllJWT(_ completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
}
