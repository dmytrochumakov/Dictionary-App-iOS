//
//  MDAPIAccount.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 25.08.2021.
//

import Foundation

protocol MDAPIAccountProtocol {
    
    func deleteAccount(accessToken: String,
                       userId: Int64,
                       completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
    
}

final class MDAPIAccount: MDAPIAccountProtocol {
    
    fileprivate let requestDispatcher: MDRequestDispatcherProtocol
    fileprivate let operationQueue: OperationQueue
    
    init(requestDispatcher: MDRequestDispatcherProtocol,
         operationQueue: OperationQueue) {
        
        self.requestDispatcher = requestDispatcher
        self.operationQueue = operationQueue
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Endpoint
extension MDAPIAccount {
    
    enum MDAPIAccountEndpoint: MDEndpoint {
        
        case deleteAccount(accessToken: String,
                           userId: Int64)
        
        var path: String {
            switch self {
            case .deleteAccount(_, let userId):
                return "account/deleteAccount/userId/\(userId)"
            }
        }
        
        var httpMethod: HTTPMethod {
            switch self {
            case .deleteAccount:
                return .delete
            }
        }
        
        var httpHeaders: HTTPHeader {
            switch self {
            case .deleteAccount(let accessToken, _):
                return MDConstants
                    .HTTPHeaderConstants
                    .authorizationHeaders(accessToken: accessToken)
            }
        }
        
        var httpParameters: HTTPParameters? {
            switch self {
            case .deleteAccount:
                return nil
            }
        }
        
        var requestType: MDRequestType {
            switch self {
            case .deleteAccount:
                return .data
            }
        }
        
        var responseType: MDResponseType {
            switch self {
            case .deleteAccount:
                return .data
            }
        }
        
    }
    
}

extension MDAPIAccount {
    
    func deleteAccount(accessToken: String,
                       userId: Int64,
                       completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        let operation: MDAPIOperation = .init(requestDispatcher: self.requestDispatcher,
                                              endpoint: MDAPIAccountEndpoint.deleteAccount(accessToken: accessToken,
                                                                                           userId: userId)) { result in
            
            switch result {
                
            case .data:
                
                completionHandler(.success(()))
                
                break
                
            case .error(let error, _):
                
                debugPrint(#function, Self.self, "error: ", error.localizedDescription)
                
                completionHandler(.failure(error))
                
                break
                
            }
        }
        
        operationQueue.addOperation(operation)
        
    }
    
}
