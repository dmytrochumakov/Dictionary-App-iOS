//
//  MDAPIOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.07.2021.
//

import Foundation

final class MDAPIOperation {
    
    typealias Output = MDResponseOperationResult
    
    fileprivate var task: URLSessionTask?
    internal var endpoint: MDEndpoint
    
    init(_ endpoint: MDEndpoint) {
        self.endpoint = endpoint
    }
    
    deinit {
        debugPrint(Self.self, #function)
    }
    
}

// MARK: - Execute
extension MDAPIOperation {
 
    func execute(in requestDispatcher: MDRequestDispatcherProtocol, completion: @escaping (MDResponseOperationResult) -> Void) {
        task = requestDispatcher.execute(endpoint: endpoint, completion: { result in
            completion(result)
        })
    }
    
}

// MARK: - Cancel
extension MDAPIOperation {

    func cancel() {
        task?.cancel()
    }
    
}
