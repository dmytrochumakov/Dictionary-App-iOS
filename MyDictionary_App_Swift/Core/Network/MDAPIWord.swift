//
//  MDAPIWord.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.07.2021.
//

import Foundation

protocol MDAPIWordProtocol {
    func create()
}

final class MDAPIWord: MDAPIWordProtocol {
    
    fileprivate let requestDispatcher: MDRequestDispatcherProtocol
    
    convenience init() {
        self.init(requestDispatcher: MDRequestDispatcher.init(environment: MDAPIEnvironment.openLibrary,
                                                              networkSession: MDNetworkSession()))
    }
    
    init(requestDispatcher: MDRequestDispatcherProtocol) {
        self.requestDispatcher = requestDispatcher
    }
    
    enum MDWordEndpoint: MDEndpoint {
        
        case createWord
        
        var path: String {
            switch self {
            case .createWord:
                return "books/OL7353617M.json"
            }
        }
        
        var httpMethod: HTTPMethod {
            switch self {
            case .createWord:
                return .get
            }
        }
        
        var httpHeaders: HTTPHeader {
            switch self {
            case .createWord:
                return Constants.HTTPHeaderConstants.defaultHeaders()
            }
        }
        
        var httpParameters: HTTPParameters? {
            switch self {
            case .createWord:
                return nil
            }
        }
        
        var requestType: MDRequestType {
            switch self {
            case .createWord:
                return .data
            }
        }
        
        var responseType: MDResponseType {
            switch self {
            case .createWord:
                return .data
            }
        }
        
    }
    
}

// MARK: - Create
extension MDAPIWord {
    
    func create() {
        MDAPIOperation.init(MDWordEndpoint.createWord)
            .execute(in: requestDispatcher) { [unowned self] (response) in
                switch response {
                case .data(let data, _):
                    debugPrint(data.count)
                    break
                case .error(let error, _):
                    break
                }
            }
    }
    
}
