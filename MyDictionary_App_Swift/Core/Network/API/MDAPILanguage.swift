//
//  MDAPILanguage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 22.08.2021.
//

import Foundation

protocol MDAPILanguageProtocol {
    func getLanguages(accessToken: String,
                      _ completionHandler: @escaping(MDLanguagesResponseResultWithCompletion))
}

final class MDAPILanguage: MDAPILanguageProtocol {
    
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

extension MDAPILanguage {
    
    enum MDAPILanguageEndpoint: MDEndpoint {
        
        case getLanguages(accessToken: String)
        
        var path: String {
            switch self {
            case .getLanguages:
                return "languages"
            }
        }
        
        var httpMethod: HTTPMethod {
            switch self {
            case .getLanguages:
                return .get
            }
        }
        
        var httpHeaders: HTTPHeader {
            switch self {
            case .getLanguages(let accessToken):
                return Constants.HTTPHeaderConstants.authorizationHeaders(accessToken: accessToken)
            }
        }
        
        var httpParameters: HTTPParameters? {
            switch self {
            case .getLanguages:
                return nil
            }
        }
        
        var requestType: MDRequestType {
            switch self {
            case .getLanguages:
                return .data
            }
        }
        
        var responseType: MDResponseType {
            switch self {
            case .getLanguages:
                return .data
            }
        }
        
    }
    
}

extension MDAPILanguage {
    
    func getLanguages(accessToken: String,
                      _ completionHandler: @escaping(MDLanguagesResponseResultWithCompletion)) {
        
        let operation: MDAPIOperation = .init(requestDispatcher: self.requestDispatcher,
                                              endpoint: MDAPILanguageEndpoint.getLanguages(accessToken: accessToken)) { result in
            
            switch result {
            
            case .data(let data, _):
                
                guard let data = data else { completionHandler(.failure(MDAPIError.noData)) ; return }
                
                debugPrint(#function, Self.self, "dataCount: ", data.count)
                
                do {
                    completionHandler(.success(try JSONDecoder.init().decode([LanguageResponse].self, from: data)))
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
