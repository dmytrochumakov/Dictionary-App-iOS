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
            return LocalizedText.noDataApiError.localized
        case .invalidResponse:
            return LocalizedText.invalidResponseApiError.localized
        case .badRequest:
            return LocalizedText.badRequestApiError.localized
        case .unauthorized:
            return LocalizedText.unauthorizedApiError.localized
        case .forbidden:
            return LocalizedText.forbiddenApiError.localized
        case .notFound:
            return LocalizedText.notFoundApiError.localized
        case .methodNotAllowed:
            return LocalizedText.methodNotAllowedApiError.localized
        case .conflict:
            return LocalizedText.conflictApiError.localized
        case .internalServerError:
            return LocalizedText.internalServerErrorApiError.localized
        case .parseError:
            return LocalizedText.parseErrorApiError.localized
        case .noInternetConnection:
            return LocalizedText.noInternetConnection.localized
        case .unknown:
            return LocalizedText.unknownApiError.localized
        }
    }
    
}
