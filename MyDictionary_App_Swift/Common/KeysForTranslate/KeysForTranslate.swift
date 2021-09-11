//
//  KeysForTranslate.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import Foundation

enum KeysForTranslate: String {
    case edit
    case cancel
    case done
    case error
    case words
    case settings
    case appearance
    case automatic
    case dark
    case light
    case courses
    case add
    case authorization
    case nickname
    case login
    case password
    case nicknameIsEmpty = "nickname_Is_Empty"
    case passwordIsEmpty = "password_Is_Empty"
    case ok
    
    // Api Errors //
    case noDataApiError = "no_data_api_error"
    case invalidResponseApiError = "invalid_response_api_error"
    case badRequestApiError = "bad_request_api_error"
    case unauthorizedApiError = "unauthorized_api_error"
    case forbiddenApiError = "forbidden_api_error"
    case notFoundApiError = "not_found_api_error"
    case methodNotAllowedApiError = "method_not_allowed_api_error"
    case conflictApiError = "conflict_api_error"
    case internalServerErrorApiError = "internal_server_error_api_error"
    case parseErrorApiError = "parse_error_api_error"
    case unknownApiError = "unknown_api_error"
    // End Api Errors //
    
    // Api Auth Errors //
    case unauthorizedApiAuthError = "unauthorized_api_auth_error"
    case conflictApiAuthError = "conflict_api_auth_error"
    // End Api Auth Errors //
    
    case registration
    case register
    case youAreOffline = "you_are_offline"
    case pleaseCheckYourInternetConnection = "please_check_your_internet_connection"
    case noInternetConnection = "no_internet_connection"
    
}

// MARK: - LocalizableProtocol
extension KeysForTranslate: LocalizableProtocol {
    
    /// Default is Constants.StaticText.defaultTableName
    var tableName: String {
        return MDConstants.StaticText.defaultTableName
    }
    
}
