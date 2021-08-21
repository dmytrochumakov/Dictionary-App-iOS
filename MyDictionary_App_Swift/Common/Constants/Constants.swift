//
//  Constants.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import UIKit
import Reachability

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
        static let spaceString: String = " "
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
        fileprivate static let sessionConfiguration: URLSessionConfiguration = .default
        /// Default is 30 seconds
        fileprivate static let timeoutIntervalForResource: TimeInterval = 30
        /// Default is 3
        fileprivate static let maxConcurrentOperationCount: Int = 3
        /// Default is QualityOfService.userInitiated
        fileprivate static let qualityOfService: QualityOfService = .userInitiated
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
    
    struct Environment {
        /// MDEnvironment.development by default
        static let current: MDEnvironment = .development
    }
    
    struct APIEnvironment {
        
        /// Depends on the current MDEnvironment
        static var current: MDAPIEnvironment {
            switch Environment.current {
            case .development:
                return .development
            case .production:
                return .production
            }
        }
        
    }
    
    struct AppDependencies {
        
        static var dependencies: MDAppDependenciesProtocol {
            return (UIApplication.shared.delegate as! MDAppDelegate).dependencies
        }
        
    }
    
    struct NetworkSession {
        
        static var defaultNetworkSession: MDNetworkSessionProtocol {
            return MDNetworkSession.init(configuration: URLSessionConfigurationConstants.sessionWithConfiguration,
                                         delegateQueue: URLSessionConfigurationConstants.sessionConfigurationOperationQueue)
        }
        
    }
    
    
    struct RequestDispatcher {
        
        static func defaultRequestDispatcher(reachability: Reachability) -> MDRequestDispatcherProtocol {
            return MDRequestDispatcher.init(reachability: reachability,
                                            environment: APIEnvironment.current,
                                            networkSession: NetworkSession.defaultNetworkSession)
        }
        
    }
    
}
