//
//  Endpoint.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.07.2021.
//

import Foundation

protocol MDEndpoint {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var httpHeaders: HTTPHeader { get }
    var httpParameters: HTTPParameters? { get }
    var requestType: MDRequestType { get }
    var responseType: MDResponseType { get }
}

extension MDEndpoint {
    
    public func urlRequest(with environment: MDEnvironmentProtocol) -> URLRequest? {
        
        guard let url = url(with: environment.baseURL) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        
        // Append all related properties.
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = httpHeaders
        request.httpBody = httpBody
        
        return request
    }
    
}

fileprivate extension MDEndpoint {
    
    func url(with baseURL: String) -> URL? {
        guard var urlComponents = URLComponents(string: baseURL) else {
            return nil
        }
        urlComponents.path = urlComponents.path + path
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
    
    /// Returns the URLRequest `URLQueryItem`
    var queryItems: [URLQueryItem]? {
        // Chek if it is a GET method.
        guard httpMethod == .get, let parameters = httpParameters else {
            return nil
        }
        guard let dict = ((try? JSONSerialization.jsonObject(with: parameters, options: [])) as? [String: Any]) else {
            return nil
        }
        // Convert parameters to query items.
        return dict.map { (key: String, value: Any) -> URLQueryItem in
            let valueString = String(describing: value)
            return URLQueryItem(name: key, value: valueString)
        }
    }
    
    /// Returns the URLRequest body `Data`
    var httpBody: Data? {
        // The body data should be used for POST, PUT and DELETE only
        guard [.post, .put, .delete].contains(httpMethod), let data = httpParameters else {
            return nil
        }
        return data
    }
    
}
