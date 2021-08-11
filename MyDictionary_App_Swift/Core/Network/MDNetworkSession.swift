//
//  MDNetworkSession.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.07.2021.
//

import Foundation

protocol MDNetworkSessionProtocol {
    /// Create  a URLSessionDataTask. The caller is responsible for calling resume().
    /// - Parameters:
    ///   - request: `URLRequest` object.
    ///   - completionHandler: The completion handler for the data task.
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask?
}

final class MDNetworkSession: NSObject {
    
    fileprivate typealias CompletionHandler = (((URL?, URLResponse?, Error?) -> Void)?)
    /// The URLSession handing the URLSessionTaks.
    fileprivate var session: URLSession!
    fileprivate var taskToHandlersMap: [URLSessionTask : CompletionHandler] = [:]
    
    deinit {
        // We have to invalidate the session becasue URLSession strongly retains its delegate. https://developer.apple.com/documentation/foundation/urlsession/1411538-invalidateandcancel
        session.invalidateAndCancel()
        session = nil
        taskToHandlersMap = [:]
        debugPrint(Self.self, #function)
    }
        
    public override convenience init() {
        // Configure the default URLSessionConfiguration.
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForResource = 30        
        
        // Create a `OperationQueue` instance for scheduling the delegate calls and completion handlers.
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 3
        queue.qualityOfService = .userInitiated
        
        // Call the designated initializer
        self.init(configuration: sessionConfiguration, delegateQueue: queue)
    }
        
    public init(configuration: URLSessionConfiguration, delegateQueue: OperationQueue) {
        super.init()
        self.session = URLSession.init(configuration: configuration, delegate: self, delegateQueue: delegateQueue)
    }
            
    fileprivate func set(handlers: CompletionHandler?, for task: URLSessionTask) {
        taskToHandlersMap[task] = handlers
    }
        
    fileprivate func getHandlers(for task: URLSessionTask) -> CompletionHandler? {
        return taskToHandlersMap[task]
    }
    
}

// MARK: - URLSessionDelegate
extension MDNetworkSession: URLSessionDelegate {
    
}

// MARK: - NetworkSessionProtocol
extension MDNetworkSession: MDNetworkSessionProtocol {

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            completionHandler(data, response, error)
        }
        return dataTask
    }

}
