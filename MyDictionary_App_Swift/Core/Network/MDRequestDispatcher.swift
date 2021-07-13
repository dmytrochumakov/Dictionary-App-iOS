//
//  MDRequestDispatcher.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.07.2021.
//

import Foundation

protocol MDRequestDispatcherProtocol {
    init(environment: MDEnvironmentProtocol, networkSession: MDNetworkSessionProtocol)
    func execute(endpoint: MDEndpoint, completion: @escaping (MDResponseOperationResult) -> Void) -> URLSessionTask?
}

final class MDRequestDispatcher: MDRequestDispatcherProtocol {
    
    /// The environment configuration.
    fileprivate var environment: MDEnvironmentProtocol
    /// The network session configuration.
    fileprivate var networkSession: MDNetworkSessionProtocol
    
    required init(environment: MDEnvironmentProtocol, networkSession: MDNetworkSessionProtocol) {
        self.environment = environment
        self.networkSession = networkSession
    }
    
    deinit {
        debugPrint(Self.self, #function)
    }
    
}

// MARK: - Execute
extension MDRequestDispatcher {
    
    func execute(endpoint: MDEndpoint, completion: @escaping (MDResponseOperationResult) -> Void) -> URLSessionTask? {
        // Create a URL request.
        guard let urlRequest = endpoint.urlRequest(with: environment) else {
            completion(.error(MDAPIError.badRequest("Invalid URL for: \(endpoint)"), nil))
            return nil
        }
        
        // Create a URLSessionTask to execute the URLRequest.
        var task: URLSessionTask?
        switch endpoint.requestType {
        case .data:
            task = networkSession.dataTask(with: urlRequest, completionHandler: { (data, urlResponse, error) in
                self.handleJsonTaskResponse(data: data, urlResponse: urlResponse, error: error, completion: completion)
            })
            break
        }
        
        // Start the task.
        task?.resume()
        
        return task
    }
    
}

fileprivate extension MDRequestDispatcher {
    
    func handleJsonTaskResponse(data: Data?, urlResponse: URLResponse?, error: Error?, completion: @escaping (MDResponseOperationResult) -> Void) {
        // Check if the response is valid.
        guard let urlResponse = urlResponse as? HTTPURLResponse else {
            completion(MDResponseOperationResult.error(MDAPIError.invalidResponse, nil))
            return
        }
        // Verify the HTTP status code.
        let result = verify(data: data, urlResponse: urlResponse, error: error)
        switch result {
        case .success(let data):
            DispatchQueue.main.async {
                completion(MDResponseOperationResult.data(data, urlResponse))
            }
        case .failure(let error):
            DispatchQueue.main.async {
                completion(MDResponseOperationResult.error(error, urlResponse))
            }
        }
    }
    
    func verify(data: Data?, urlResponse: HTTPURLResponse, error: Error?) -> Result<Data, Error> {
        switch urlResponse.statusCode {
        case 200...299:
            if let data = data {
                return .success(data)
            } else {
                return .failure(MDAPIError.noData)
            }
        case 400...499:
            return .failure(MDAPIError.badRequest(error?.localizedDescription))
        case 500...599:
            return .failure(MDAPIError.serverError(error?.localizedDescription))
        default:
            return .failure(MDAPIError.unknown)
        }
    }
    
}
