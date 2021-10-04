//
//  MDAPIUser.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 24.08.2021.
//

import Foundation

protocol MDAPIUserProtocol {
    func getUser(accessToken: String,
                 byUserId userId: Int64,
                 completionHandler: @escaping(MDOperationResultWithCompletion<UserResponse>))
}

final class MDAPIUser: MDAPIUserProtocol {
    
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

extension MDAPIUser {
    
    enum MDAPIUserEndpoint: MDEndpoint {
        
        case getUser(accessToken: String,
                     userId: Int64)
        
        var path: String {
            switch self {
            case .getUser(_ , let userID):
                return "users/\(userID)"
            }
        }
        
        var httpMethod: HTTPMethod {
            switch self {
            case .getUser:
                return .get
            }
        }
        
        var httpHeaders: HTTPHeader {
            switch self {
            case .getUser(let accessToken, _):
                return MDConstants
                    .HTTPHeaderConstants
                    .authorizationHeaders(accessToken: accessToken)
            }
        }
        
        var httpParameters: HTTPParameters? {
            switch self {
            case .getUser:
                return nil
            }
        }
        
        var requestType: MDRequestType {
            switch self {
            case .getUser:
                return .data
            }
        }
        
        var responseType: MDResponseType {
            switch self {
            case .getUser:
                return .data
            }
        }
        
    }
    
}

extension MDAPIUser {
    
    func getUser(accessToken: String,
                 byUserId userId: Int64,
                 completionHandler: @escaping(MDOperationResultWithCompletion<UserResponse>)) {
        
        let operation: MDAPIOperation = .init(requestDispatcher: self.requestDispatcher,
                                              endpoint: MDAPIUserEndpoint.getUser(accessToken: accessToken,
                                                                                  userId: userId)) { result in
            
            switch result {
                
            case .data(let data, _):
                
                guard let data = data else { completionHandler(.failure(MDAPIError.noData)) ; return }
                
                debugPrint(#function, Self.self, "dataCount: ", data.count)
                
                do {
                    completionHandler(.success(try JSONDecoder.init().decode(UserResponse.self, from: data)))
                } catch (_) {
                    completionHandler(.failure(MDAPIError.parseError))
                }
                
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
