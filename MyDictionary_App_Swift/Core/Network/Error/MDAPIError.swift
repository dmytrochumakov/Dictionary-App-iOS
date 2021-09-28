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
            return MDLocalizedText.noDataApiError.localized
        case .invalidResponse:
            return MDLocalizedText.invalidResponseApiError.localized
        case .badRequest:
            return MDLocalizedText.badRequestApiError.localized
        case .unauthorized:
            return MDLocalizedText.unauthorizedApiError.localized
        case .forbidden:
            return MDLocalizedText.forbiddenApiError.localized
        case .notFound:
            return MDLocalizedText.notFoundApiError.localized
        case .methodNotAllowed:
            return MDLocalizedText.methodNotAllowedApiError.localized
        case .conflict:
            return MDLocalizedText.conflictApiError.localized
        case .internalServerError:
            return MDLocalizedText.internalServerErrorApiError.localized
        case .parseError:
            return MDLocalizedText.parseErrorApiError.localized
        case .noInternetConnection:
            return MDLocalizedText.noInternetConnection.localized
        case .unknown:
            return MDLocalizedText.unknownApiError.localized
        }
    }
    
}
