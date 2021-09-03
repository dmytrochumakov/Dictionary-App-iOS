//
//  MDAPIAuth.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.08.2021.
//

import Foundation

protocol MDAPIAuthProtocol {
    func login(authRequest: AuthRequest, completionHandler: @escaping MDOperationResultWithCompletion<AuthResponse>)
    func register(authRequest: AuthRequest, completionHandler: @escaping MDOperationResultWithCompletion<AuthResponse>)
}

final class MDAPIAuth: MDAPIAuthProtocol {
    
    fileprivate let requestDispatcher: MDRequestDispatcherProtocol
    fileprivate let operationQueueService: OperationQueueServiceProtocol
    
    init(requestDispatcher: MDRequestDispatcherProtocol,
         operationQueueService: OperationQueueServiceProtocol) {
        
        self.requestDispatcher = requestDispatcher
        self.operationQueueService = operationQueueService
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Endpoint
extension MDAPIAuth {
    
    enum MDAPIAuthEndpoint: MDEndpoint {
        
        case login(authRequest: AuthRequest)
        case register(authRequest: AuthRequest)
        
        var path: String {
            switch self {
            case .login:
                return "auth/login"
            case .register:
                return "auth/register"
            }
        }
        
        var httpMethod: HTTPMethod {
            switch self {
            case .login, .register:
                return .post
            }
        }
        
        var httpHeaders: HTTPHeader {
            switch self {
            case .login, .register:
                return Constants.HTTPHeaderConstants.defaultHeaders()
            }
        }
        
        var httpParameters: HTTPParameters? {
            switch self {
            case .login(let authRequest),
                 .register(let authRequest):
                return authRequest.data
            }
        }
        
        var requestType: MDRequestType {
            switch self {
            case .login, .register:
                return .data
            }
        }
        
        var responseType: MDResponseType {
            switch self {
            case .login, .register:
                return .data
            }
        }
        
    }
    
}

// MARK: - Auth
extension MDAPIAuth {
    
    func login(authRequest: AuthRequest, completionHandler: @escaping MDOperationResultWithCompletion<AuthResponse>) {
        
        let operation: MDAPIOperation = .init(requestDispatcher: self.requestDispatcher,
                                              endpoint: MDAPIAuthEndpoint.login(authRequest: authRequest)) { result in
            
            switch result {
            
            case .data(let data, _):
                
                guard let data = data else { completionHandler(.failure(MDAPIError.noData)) ; return }
                
                debugPrint(#function, Self.self, "dataCount: ", data.count)
                
                do {
                    completionHandler(.success(try JSONDecoder.init().decode(AuthResponse.self, from: data)))
                } catch (_) {
                    completionHandler(.failure(MDAPIError.parseError))
                }
                
                break
                
            case .error(let error, let httpURLResponse):
                
                debugPrint(#function, Self.self, "error: ", error.localizedDescription)
                
                if (httpURLResponse?.statusCode == MDAPIStatusCode.unauthorized.rawValue) {
                    completionHandler(.failure(MDAPIAuthError.unauthorized))
                } else {
                    completionHandler(.failure(error))
                }
                
                break
                
            }
        }
        
        operationQueueService.enqueue(operation)
        
    }
    
    
    func register(authRequest: AuthRequest, completionHandler: @escaping MDOperationResultWithCompletion<AuthResponse>) {
        
        let operation: MDAPIOperation = .init(requestDispatcher: self.requestDispatcher,
                                              endpoint: MDAPIAuthEndpoint.register(authRequest: authRequest)) { result in
            
            switch result {
            
            case .data(let data, _):
                
                guard let data = data else { completionHandler(.failure(MDAPIError.noData)) ; return }
                
                debugPrint(#function, Self.self, "dataCount: ", data.count)
                
                do {
                    completionHandler(.success(try JSONDecoder.init().decode(AuthResponse.self, from: data)))
                } catch (_) {
                    completionHandler(.failure(MDAPIError.parseError))
                }
                
                break
                
            case .error(let error, let httpURLResponse):
                
                debugPrint(#function, Self.self, "error: ", error.localizedDescription)
                
                if (httpURLResponse?.statusCode == MDAPIStatusCode.conflict.rawValue) {
                    completionHandler(.failure(MDAPIAuthError.conflict))
                } else {
                    completionHandler(.failure(error))
                }
                
                break
                
            }
        }
        
        operationQueueService.enqueue(operation)
    }
    
}
