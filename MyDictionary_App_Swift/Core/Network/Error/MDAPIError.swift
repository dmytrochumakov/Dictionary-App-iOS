//
//  MDAPIError.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.07.2021.
//

import Foundation

enum MDAPIError: Error {
    case noData
    case invalidResponse
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case methodNotAllowed
    case conflict
    case internalServerError
    case parseError
    case noInternetConnection
    case unknown    
}

extension MDAPIError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .noData:
            return KeysForTranslate.noDataApiError.localized
        case .invalidResponse:
            return KeysForTranslate.invalidResponseApiError.localized
        case .badRequest:
            return KeysForTranslate.badRequestApiError.localized
        case .unauthorized:
            return KeysForTranslate.unauthorizedApiError.localized
        case .forbidden:
            return KeysForTranslate.forbiddenApiError.localized
        case .notFound:
            return KeysForTranslate.notFoundApiError.localized
        case .methodNotAllowed:
            return KeysForTranslate.methodNotAllowedApiError.localized
        case .conflict:
            return KeysForTranslate.conflictApiError.localized
        case .internalServerError:
            return KeysForTranslate.internalServerErrorApiError.localized
        case .parseError:
            return KeysForTranslate.parseErrorApiError.localized
        case .noInternetConnection:
            return KeysForTranslate.noInternetConnection.localized
        case .unknown:
            return KeysForTranslate.unknownApiError.localized
        }
    }
    
}
