//
//  MDAPIOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.07.2021.
//

import Foundation

typealias MDAPIOperationResult = ((MDAPIOperation.Output) -> Void)

final class MDAPIOperation: MDAsyncOperation {
    
    typealias Output = MDResponseOperationResult
    
    fileprivate let requestDispatcher: MDRequestDispatcherProtocol
    fileprivate let endpoint: MDEndpoint
    fileprivate let result: MDAPIOperationResult?
    
    fileprivate var task: URLSessionTask?
    
    init(requestDispatcher: MDRequestDispatcherProtocol,
         endpoint: MDEndpoint,
         result: MDAPIOperationResult?) {
        
        self.requestDispatcher = requestDispatcher
        self.endpoint = endpoint
        self.result = result
        
    }
    
    override func main() {
        self.task = self.requestDispatcher.execute(endpoint: self.endpoint) { [weak self] result in
            self?.result?(result)
            self?.finish()
        }
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.task?.cancel()
        self.task = nil
        self.finish()
    }
    
}
