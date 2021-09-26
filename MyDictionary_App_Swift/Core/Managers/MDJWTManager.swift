//
//  MDJWTManager.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.08.2021.
//

import Foundation

struct MDUserAndJWT {
    let user: UserResponse
    let jwt: JWTResponse
}

protocol MDJWTManagerProtocol {
    func fetchUserAndJWT(_ completionHandler: @escaping(MDOperationResultWithCompletion<MDUserAndJWT>))
}

final class MDJWTManager: MDJWTManagerProtocol {
    
    fileprivate let userMemoryStorage: MDUserMemoryStorageProtocol
    fileprivate let jwtStorage: MDJWTStorageProtocol
    fileprivate let apiJWT: MDAPIJWTProtocol
    
    init(userMemoryStorage: MDUserMemoryStorageProtocol,
         jwtStorage: MDJWTStorageProtocol,
         apiJWT: MDAPIJWTProtocol) {
        
        self.userMemoryStorage = userMemoryStorage
        self.jwtStorage = jwtStorage
        self.apiJWT = apiJWT
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDJWTManager {
    
    func fetchUserAndJWT(_ completionHandler: @escaping(MDOperationResultWithCompletion<MDUserAndJWT>)) {
        
        userMemoryStorage.readFirstUser { [unowned self] readUserResult in
            
            switch readUserResult {
                
            case .success(let userResponse):
                
                fetchJWT(nickname: userResponse.nickname,
                         password: userResponse.password!,
                         userId: userResponse.userId) { (fetchResult) in
                    
                    switch fetchResult {
                        
                    case .success(let jwtResponse):
                        
                        completionHandler(.success(.init(user: userResponse,
                                                         jwt: jwtResponse)))
                        break
                        
                    case .failure(let error):
                        
                        completionHandler(.failure(error))
                        break
                        
                    }
                }
                
            case .failure(let error):
                
                completionHandler(.failure(error))
                break
                
            }
        }
        
    }
    
}

fileprivate extension MDJWTManager {
    
    func fetchJWT(nickname: String,
                  password: String,
                  userId: Int64,
                  _ completionHandler: @escaping MDOperationResultWithCompletion<JWTResponse>) {
        
        
        self.fetchJWT(jwtApiRequest: .init(nickname: nickname,
                                           password: password,
                                           userId: userId,
                                           oldJWT:
                                            "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxLGEsYSIsImlzcyI6ImNvbS5kY2hwcm9qZWN0cy5teWRpY3Rpb25hcnlyZXN0YXBpIiwiaWF0IjoxNjMxNzkwNTI5LCJleHAiOjE2MzE3OTQxMjl9.GyX4FznJMKL2rnXmfE8xwzVSJ_pZ_tkR3eb-pB67D7_Vzu8zaXPxO9UIIOjNGHGpFo8_KzsoTdeYQCYQjRxB8g")) { fetchResult in
            
            switch fetchResult {
                
            case .success(let jwtResponse):
                
                completionHandler(.success(jwtResponse))
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
            
        }
        
    }
    
}

fileprivate extension MDJWTManager {
    
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
                                    
                                case .success:
                                    
                                    completionHandler(.success(fetchedJWTResponse))
                                    
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
