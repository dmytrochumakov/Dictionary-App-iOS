//
//  MDLocalizedText.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import Foundation

enum MDLocalizedText: String {
    
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
    case confirmPassword = "confirm_password"
    case nicknameIsEmpty = "nickname_Is_Empty"
    case passwordIsEmpty = "password_Is_Empty"
    case confirmPasswordIsEmpty = "confirm_password_Is_Empty"
    case confirmPasswordAndPasswordDoNotMatch = "confirm_password_and_password_do_not_match"
    case ok
    case pleaseWaitForDataSync = "please_wait_for_data_sync"
    case search
    case about
    case account
    case privacyPolicy = "privacy_Policy"
    case termsOfService = "terms_Of_Service"    
    case delete
    case logOut = "log_out"
    case shareFeedback = "share_feedback"
    case featureRequest = "feature_request"
    case bugReport = "bug_report"
    case mailServicesAreNotAvailable = "mail_services_are_not_available"
    case addCourse = "add_course"
    case pleaseSelectACourse = "please_select_a_course"
    case addWord = "add_word"
    case wordText = "word_text"
    case wordDescription = "word_description"
    case update
    case wordTextIsEmpty = "word_text_is_empty"
    case wordDescriptionIsEmpty = "word_description_is_empty"
    case appLanguage = "app_language"
    
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
    case conflictApiCourseError = "conflict_api_course_error"
    case conflictApiWordError = "conflict_api_word_error"
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
extension MDLocalizedText: MDLocalizableProtocol {
    
    /// Default is Constants.StaticText.defaultTableName
    var tableName: String {
        return MDConstants.StaticText.defaultTableName
    }
    
}
