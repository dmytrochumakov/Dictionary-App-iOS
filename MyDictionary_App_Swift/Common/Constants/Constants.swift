//
//  Constants.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import Foundation

struct Constants {
    
    struct StaticText {
        static let emptyString: String = ""
        static let defaultTableName: String = "Localizable"
        static let appName: String = "MyDictionary_App_Swift"
        static let dot = "."
        static let momdExtension: String = "momd"
        static let omoExtension: String = "omo"
        static let momExtension: String = "mom"
        static let sqliteExtension: String = "sqlite"
    }
    
    struct HTTPHeaderConstants {
        
        static let contentType: String = "Content-Type"
        static let applicationJson: String = "application/json"
        
        /// return
        /// Content-Type : application/json
        static func defaultHeaders() -> HTTPHeader {
            return [contentType : applicationJson]
        }
        
    }
    
    struct URLSessionConfigurationConstants {
        /// Default is default
        static let sessionConfiguration: URLSessionConfiguration = .default
        /// Default is 30 seconds
        static let timeoutIntervalForResource: TimeInterval = 30
        /// Default is 3
        static let maxConcurrentOperationCount: Int = 3
        /// Default is QualityOfService.userInitiated
        static let qualityOfService: QualityOfService = .userInitiated
        /// Default is .init()
        static var sessionConfigurationOperationQueue: OperationQueue {
            let operationQueue: OperationQueue = .init()
            operationQueue.maxConcurrentOperationCount = self.maxConcurrentOperationCount
            operationQueue.qualityOfService = self.qualityOfService
            return operationQueue
        }
        /// Configure the default URLSessionConfiguration.
        static var sessionWithConfiguration: URLSessionConfiguration {
            let defaultSessionConfiguration: URLSessionConfiguration = self.sessionConfiguration
            defaultSessionConfiguration.timeoutIntervalForResource = self.timeoutIntervalForResource
            return defaultSessionConfiguration
        }
    }
    
}
