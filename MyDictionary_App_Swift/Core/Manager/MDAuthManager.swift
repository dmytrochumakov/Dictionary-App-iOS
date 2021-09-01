//
//  MDAuthManager.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.08.2021.
//

import Foundation

protocol MDAuthManagerProtocol {
    func login(authRequest: AuthRequest, completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
    func register(authRequest: AuthRequest, completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
}

final class MDAuthManager: MDAuthManagerProtocol {
    
    fileprivate let apiAuth: MDAPIAuthProtocol
    fileprivate let appSettings: AppSettingsProtocol
    fileprivate let syncManager: SyncManagerProtocol
    
    init(apiAuth: MDAPIAuthProtocol,
         appSettings: AppSettingsProtocol,
         syncManager: SyncManagerProtocol) {
        
        self.apiAuth = apiAuth
        self.appSettings = appSettings
        self.syncManager = syncManager
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDAuthManager {
    
    func login(authRequest: AuthRequest, completionHandler: @escaping(MDOperationResultWithCompletion<Void>)) {
        
        apiAuth.login(authRequest: authRequest) { [unowned self] loginResult in
            
            switch loginResult {
            
            case .success(let authResponse):
                
                syncManager.start(withSyncItem: .init(accessToken: authResponse.jwtResponse.accessToken,
                                                      password: authRequest.password,
                                                      userId: authResponse.userResponse.userId,
                                                      nickname: authRequest.nickname))
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
            
        }
        
    }
    
    func register(authRequest: AuthRequest, completionHandler: @escaping(MDOperationResultWithCompletion<Void>)) {
        
        apiAuth.register(authRequest: authRequest) { [unowned self] registerResult in
            
            switch registerResult {
            
            case .success(let authResponse):
                                
                break
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
            
        }
        
    }
    
}

fileprivate extension MDAuthManager {
    
    func setIsLoggedInIntoTrue() {
        appSettings.setIsLoggedIn(true)
    }
    
}
