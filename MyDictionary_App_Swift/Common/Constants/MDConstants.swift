//
//  MDConstants.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import UIKit
import Reachability

struct MDConstants {
    
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
        static let forwardSlash: String = "/"
        static let colon: String = ":"
    }
    
    struct HTTPHeaderConstants {
        
        static let contentType: String = "Content-Type"
        static let authorization: String = "Authorization"
        static let applicationJson: String = "application/json"
        static let bearer: String = "Bearer "
        
        /// return
        /// Content-Type : application/json
        static func defaultHeaders() -> HTTPHeader {
            return [contentType : applicationJson]
        }
        
        /// return
        /// Content-Type : application/json
        /// Authorization : Bearer
        static func authorizationHeaders(accessToken: String) -> HTTPHeader {
            return [contentType   : applicationJson,
                    authorization : bearer + accessToken
            ]
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
        static let current: MDEnvironment = .production
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
    
    struct Screen {
        static let size: CGSize = UIScreen.main.bounds.size
        static let width: CGFloat = size.width
        static let height: CGFloat = size.height
    }
    
    struct StatusBar {
        static let size: CGSize = UIApplication.shared.statusBarFrame.size
        static let height: CGFloat = size.height
    }
    
    struct NavigationBar {
        
        static func height(fromNavigationController navigationController: UINavigationController?) -> CGFloat {
            return navigationController?.navigationBar.bounds.height ?? .zero
        }
        
        static func heightPlusStatusBarHeight(fromNavigationController navigationController: UINavigationController?) -> CGFloat {
            return height(fromNavigationController: navigationController) + StatusBar.height
        }
        
    }
    
    struct Rect {
        
        static let defaultInset: UIEdgeInsets = .init(top: .zero,
                                                      left: 16,
                                                      bottom: .zero,
                                                      right: 28)
        
        static let passwordInset: UIEdgeInsets = .init(top: .zero,
                                                       left: 16,
                                                       bottom: .zero,
                                                       right: 38)
        
        static func searchInset(searchIconImageViewLeftOffset: CGFloat) -> UIEdgeInsets {
            return .init(top: Rect.defaultInset.top,
                         left: MDConstants.Rect.defaultInset.left + searchIconImageViewLeftOffset + 6,
                         bottom: Rect.defaultInset.bottom,
                         right: Rect.defaultInset.right)
        }
        
    }
    
    struct Text {
        
        static func textIsEmpty(_ text: String?) -> Bool {
            if (text == nil || text!.isEmpty || text!.trimmingCharacters(in: .whitespaces).isEmpty) {
                return true
            } else {
                return false
            }
        }
        
        struct MaxCountCharacters {
            static let nicknameTextField: Int = 255
            static let passwordTextField: Int = 255
        }
        
    }
    
    struct Keyboard {
        
        static func hideKeyboard(rootView view: UIView) {
            view.endEditing(true)
        }
        
    }
    
    struct Font {
        static let defaultSize: CGFloat = 17
    }
    
    struct StaticURL {
        static let privacyPolicyURL: URL = .init(string: "https://dchprojects.github.io/MyDictionary-Web/privacy_policy.html")!
        static let termsOfServiceURL: URL = .init(string: "https://dchprojects.github.io/MyDictionary-Web/terms_of_service.html")!
        static let aboutAppURL: URL = .init(string: "https://dchprojects.github.io/MyDictionary-Web/index.html#about")!
    }
    
    struct ShareFeedback {
        static let recipientEmail: String = "dima.chumakovwork@gmail.com"
    }
    
}
