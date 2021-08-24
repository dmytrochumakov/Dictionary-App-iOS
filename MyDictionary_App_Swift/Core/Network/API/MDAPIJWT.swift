//
//  MDAPIJWT.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 22.08.2021.
//

import Foundation

protocol MDAPIJWTProtocol {
    func accessToken(jwtRequest: JWTRequest, completionHandler: @escaping MDJWTResponseResult)
}

final class MDAPIJWT: MDAPIJWTProtocol {
    
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
extension MDAPIJWT {
    
    enum MDAPIJWTEndpoint: MDEndpoint {
        
        case accessToken(jwtRequest: JWTRequest)
        
        var path: String {
            switch self {
            case .accessToken:
                return "auth/login"
            }
        }
        
        var httpMethod: HTTPMethod {
            switch self {
            case .accessToken:
                return .post
            }
        }
        
        var httpHeaders: HTTPHeader {
            switch self {
            case .accessToken:
                return Constants.HTTPHeaderConstants.defaultHeaders()
            }
        }
        
        var httpParameters: HTTPParameters? {
            switch self {
            case .accessToken(let jwtRequest):
                return jwtRequest.data
            }
        }
        
        var requestType: MDRequestType {
            switch self {
            case .accessToken:
                return .data
            }
        }
        
        var responseType: MDResponseType {
            switch self {
            case .accessToken:
                return .data
            }
        }
        
    }
    
}

// MARK: - Access Token
extension MDAPIJWT {
    
    func accessToken(jwtRequest: JWTRequest, completionHandler: @escaping MDJWTResponseResult) {
        
        let operation: MDAPIOperation = .init(requestDispatcher: self.requestDispatcher,
                                              endpoint: MDAPIJWTEndpoint.accessToken(jwtRequest: jwtRequest)) { result in
            
            switch result {
            
            case .data(let data, _):
                
                guard let data = data else { completionHandler(.failure(MDAPIError.noData)) ; return }
                
                debugPrint(#function, Self.self, "dataCount: ", data.count)
                
                do {
                    completionHandler(.success(try JSONDecoder.init().decode(AuthResponse.self, from: data).jwtResponse))
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
        
        operationQueueService.enqueue(operation)
        
    }
    
}
