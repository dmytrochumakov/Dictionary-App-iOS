//
//  MDConstants.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import UIKit

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
        
        fileprivate static var largeHeight: CGFloat? = nil
        fileprivate static var smallHeight: CGFloat? = nil
        
        static func height(fromNavigationController navigationController: UINavigationController?,
                           prefersLargeTitles: Bool) -> CGFloat {
            if (navigationController == nil) {
                return .zero
            } else {
                if (prefersLargeTitles) {
                    if (largeHeight == nil) {
                        navigationController!.navigationBar.prefersLargeTitles = true
                        self.largeHeight = navigationController!.navigationBar.bounds.height
                        return self.largeHeight!
                    } else {
                        return self.largeHeight!
                    }
                } else {
                    if (smallHeight == nil) {
                        navigationController!.navigationBar.prefersLargeTitles = false
                        self.smallHeight = navigationController!.navigationBar.bounds.height
                        return self.smallHeight!
                    } else {
                        return self.smallHeight!
                    }
                }
            }
        }
        
        static func heightPlusStatusBarHeight(fromNavigationController navigationController: UINavigationController?,
                                              prefersLargeTitles: Bool) -> CGFloat {
            return height(fromNavigationController: navigationController, prefersLargeTitles: prefersLargeTitles) + StatusBar.height
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
            static let wordTextField: Int = 255
            static let wordDescriptionTextView: Int = 500
        }
        
        struct Counter {
            
            static func result(text: String?,
                               rangeLength: Int,
                               string: String,
                               maxCountCharacters: Int) -> (count: Int, success: Bool) {
                
                let count: Int = computeCount(text: text,
                                              rangeLength: rangeLength,
                                              string: string)
                
                return (count, (count <= maxCountCharacters))
                
            }
            
            static func text(currentCount: Int, maxCount: Int) -> String {
                return String(currentCount) + MDConstants.StaticText.forwardSlash + String(maxCount)
            }
            
            fileprivate static func computeCount(text: String?,
                                                 rangeLength: Int,
                                                 string: String) -> Int {
                
                return (text?.count ?? .zero) + (string.count - rangeLength)
                
            }
            
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
    
    struct SearchBar {
        /// Value -> 56
        static let defaultHeight: CGFloat = 56
        /// Value -> 16
        static let defaultTopOffset: CGFloat = 16
    }
    
    struct EnglishAlphabet {
        static let uppercasedCharacters: [String] = ["A", "B", "C", "D", "E", "F", "G", "H",
                                                     "I", "J", "K", "L", "M", "N", "O", "P",
                                                     "Q", "R", "S", "T", "U", "V", "W", "X",
                                                     "Y", "Z"]
    }
    
    struct MDBundle {
        static var bundleIdentifier: String {
            guard let bundleIdentifier = Bundle.main.bundleIdentifier else { fatalError("Please Set bundleIdentifier") }
            return bundleIdentifier
        }
    }
    
    struct QueueName {
        
        // Async Operation
        //
        static let asyncOperation: String = bundleIdentifier_Plus_Dot_Plus_QueueName(queueName: String(describing: MDAsyncOperation.self))
        
        
        // Language
        //
        fileprivate static let languageShortQueueName: String = "Language"
        static let languageStorageOperationQueue: String = mdStorageOperationQueue(shortQueueName: languageShortQueueName)
        static let languageMemoryStorageOperationQueue: String = mdMemoryStorageOperationQueue(shortQueueName: languageShortQueueName)
        static let languageCoreDataStorageOperationQueue: String = mdCoreDataStorageOperationQueue(shortQueueName: languageShortQueueName)
        static let languageAPIOperationQueue: String = mdAPIOperationQueue(shortQueueName: languageShortQueueName)
        
        // Course
        //
        fileprivate static let courseShortQueueName: String = "Course"
        static let courseStorageOperationQueue: String = mdStorageOperationQueue(shortQueueName: courseShortQueueName)
        static let courseMemoryStorageOperationQueue: String = mdMemoryStorageOperationQueue(shortQueueName: courseShortQueueName)
        static let courseCoreDataStorageOperationQueue: String = mdCoreDataStorageOperationQueue(shortQueueName: courseShortQueueName)
        static let courseAPIOperationQueue: String = mdAPIOperationQueue(shortQueueName: courseShortQueueName)
        
        // JWT
        //
        fileprivate static let jwtShortQueueName: String = "JWT"
        static let jwtStorageOperationQueue: String = mdStorageOperationQueue(shortQueueName: jwtShortQueueName)
        static let jwtMemoryStorageOperationQueue: String = mdMemoryStorageOperationQueue(shortQueueName: jwtShortQueueName)
        static let jwtCoreDataStorageOperationQueue: String = mdCoreDataStorageOperationQueue(shortQueueName: jwtShortQueueName)
        static let jwtAPIOperationQueue: String = mdAPIOperationQueue(shortQueueName: jwtShortQueueName)
        
        // User
        //
        fileprivate static let userShortQueueName: String = "User"
        static let userStorageOperationQueue: String = mdStorageOperationQueue(shortQueueName: userShortQueueName)
        static let userMemoryStorageOperationQueue: String = mdMemoryStorageOperationQueue(shortQueueName: userShortQueueName)
        static let userCoreDataStorageOperationQueue: String = mdCoreDataStorageOperationQueue(shortQueueName: userShortQueueName)
        static let userAPIOperationQueue: String = mdAPIOperationQueue(shortQueueName: userShortQueueName)
        
        // Word
        //
        fileprivate static let wordShortQueueName: String = "Word"
        static let wordStorageOperationQueue: String = mdStorageOperationQueue(shortQueueName: wordShortQueueName)
        static let wordMemoryStorageOperationQueue: String = mdMemoryStorageOperationQueue(shortQueueName: wordShortQueueName)
        static let wordCoreDataStorageOperationQueue: String = mdCoreDataStorageOperationQueue(shortQueueName: wordShortQueueName)
        static let wordAPIOperationQueue: String = mdAPIOperationQueue(shortQueueName: wordShortQueueName)
        //
        
        // Auth
        //
        fileprivate static let authShortQueueName: String = "Auth"
        static let authAPIOperationQueue: String = mdAPIOperationQueue(shortQueueName: authShortQueueName)
        
        // Account
        //
        fileprivate static let accountShortQueueName: String = "Account"
        static let accountAPIOperationQueue: String = mdAPIOperationQueue(shortQueueName: accountShortQueueName)
        
        // Sync
        //
        fileprivate static let synchronizationServiceShortQueueName: String = "Synchronization_Service"
        static let synchronizationServiceOperationQueue: String = mdOperationQueue(shortQueueName: synchronizationServiceShortQueueName)
        
        // Storage Cleanup
        //
        fileprivate static let storageCleanupServiceShortQueueName: String = "Storage_Cleanup_Service"
        static let storageCleanupServiceOperationQueue: String = mdOperationQueue(shortQueueName: storageCleanupServiceShortQueueName)
        
        // Sync Manager
        //
        fileprivate static let synchronizationManagerShortQueueName: String = "Synchronization_Manager"
        static let synchronizationManagerOperationQueue: String = mdOperationQueue(shortQueueName: synchronizationManagerShortQueueName)
        
        // Fill Memory Service
        //
        fileprivate static let fillMemoryServiceQueueName: String = "Fill_Memory_Service"
        static let fillMemoryServiceOperationQueue: String = mdOperationQueue(shortQueueName: fillMemoryServiceQueueName)
        
        // Filter Search Text Service
        //
        fileprivate static let filterSearchTextServiceQueueName: String = "Filter_Search_Text_Service"
        static let filterSearchTextServiceOperationQueue: String = mdOperationQueue(shortQueueName: filterSearchTextServiceQueueName)
        
        
        //
        fileprivate static func mdAPIOperationQueue(shortQueueName: String) -> String {
            return bundleIdentifier_Plus_Dot_Plus_QueueName(queueName: "MD" + shortQueueName + "APIOperationQueue")
        }
        
        fileprivate static func mdMemoryStorageOperationQueue(shortQueueName: String) -> String {
            return bundleIdentifier_Plus_Dot_Plus_QueueName(queueName: "MD" + shortQueueName + "MemoryStorageOperationQueue")
        }
        
        fileprivate static func mdCoreDataStorageOperationQueue(shortQueueName: String) -> String {
            return bundleIdentifier_Plus_Dot_Plus_QueueName(queueName: "MD" + shortQueueName + "CoreDataStorageOperationQueue")
        }
        
        fileprivate static func mdStorageOperationQueue(shortQueueName: String) -> String {
            return bundleIdentifier_Plus_Dot_Plus_QueueName(queueName: "MD" + shortQueueName + "StorageOperationQueue")
        }
        
        fileprivate static func mdOperationQueue(shortQueueName: String) -> String {
            return bundleIdentifier_Plus_Dot_Plus_QueueName(queueName: "MD" + shortQueueName + "OperationQueue")
        }
        
        //
        fileprivate static func bundleIdentifier_Plus_Dot_Plus_QueueName(queueName: String) -> String {
            return MDBundle.bundleIdentifier + MDConstants.StaticText.dot + queueName
        }
        
    }
    
    struct MDOperationQueue {
        
        static func createOperationQueue(byName name: String) -> OperationQueue {
            let operationQueue: OperationQueue = .init()
            operationQueue.name = name
            return operationQueue
        }
        
    }
    
    struct MDNetworkActivityIndicator {
        
        static func show() {
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
        }
        
        static func hide() {
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        
    }
    
}
