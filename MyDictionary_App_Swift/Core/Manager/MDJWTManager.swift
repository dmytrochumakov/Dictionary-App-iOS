//
//  MDJWTManager.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.08.2021.
//

import Foundation

protocol MDJWTManagerProtocol {
    func fetchJWT(jwtApiRequest: JWTApiRequest, completionHandler: @escaping MDOperationResultWithCompletion<JWTResponse>)
}

final class MDJWTManager: MDJWTManagerProtocol {
    
    fileprivate let jwtStorage: MDJWTStorageProtocol
    fileprivate let apiJWT: MDAPIJWTProtocol
    
    init(jwtStorage: MDJWTStorageProtocol,
         apiJWT: MDAPIJWTProtocol) {
        
        self.jwtStorage = jwtStorage
        self.apiJWT = apiJWT
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDJWTManager {
    
    func fetchJWT(jwtApiRequest: JWTApiRequest, completionHandler: @escaping MDOperationResultWithCompletion<JWTResponse>) {
        
        jwtStorage.readFirstJWT(storageType: .memory) { [unowned self] readResults in
            
            switch readResults.first!.result {
            
            case .success(let readJWTResponse):
                
                if (isExpired(jwtExpirationDate: readJWTResponse.expDate)) {
                    
                    apiJWT.accessToken(jwtApiRequest: jwtApiRequest) { [unowned self] accessTokenResult in
                        
                        switch accessTokenResult {
                        
                        case .success(let fetchedJWTResponse):
                            
                            jwtStorage.updateJWT(storageType: .all,
                                                 oldAccessToken: readJWTResponse.accessToken,
                                                 newJWTResponse: fetchedJWTResponse) { updatedResult in
                                
                                switch updatedResult.first!.result {
                                
                                case .success(let updatedJWTResponse):
                                    
                                    completionHandler(.success(updatedJWTResponse))
                                    
                                case .failure(let error):
                                    completionHandler(.failure(error))
                                }
                                
                            }
                            
                        case .failure(let error):
                            completionHandler(.failure(error))
                        }
                        
                    }
                    
                } else {
                    completionHandler(.success(readJWTResponse))
                }
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
            
        }
        
    }
    
}

// MARK: - is Expired
fileprivate extension MDJWTManager {
    
    func isExpired(jwtExpirationDate date: Date?) -> Bool {
        guard let date = date else { return true }
        let now = Date.init()
        return now >= date
    }
    
}
