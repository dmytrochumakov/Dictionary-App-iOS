//
//  MDAPIAuth.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.08.2021.
//

import Foundation

protocol MDAPIAuthProtocol {
    func login(authRequest: AuthRequest, completionHandler: @escaping MDAuthResponseResult)
    func register(authRequest: AuthRequest)
}

final class MDAPIAuth: MDAPIAuthProtocol {
    
    fileprivate let requestDispatcher: MDRequestDispatcherProtocol
    
    init(requestDispatcher: MDRequestDispatcherProtocol) {
        self.requestDispatcher = requestDispatcher
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
    
    func login(authRequest: AuthRequest, completionHandler: @escaping MDAuthResponseResult) {
        MDAPIOperation.init(MDAPIAuthEndpoint.login(authRequest: authRequest))
            .execute(in: requestDispatcher) { [unowned self] (response) in
                switch response {
                case .data(let data, _):
                    do {
                        let jsonDecoder = JSONDecoder.init()
                        let authResponse = try jsonDecoder.decode(AuthResponse.self, from: data)
                        completionHandler(.success(authResponse))
                    } catch (let error) {
                        completionHandler(.failure(error))
                    }
                    debugPrint(#function, Self.self, "dataCount: ", data.count)
                    break
                case .error(let error, _):
                    debugPrint(#function, Self.self, "error: ", error.localizedDescription)
                    completionHandler(.failure(error))
                    break
                }
            }
    }
    
    func register(authRequest: AuthRequest) {
        
    }
    
}
