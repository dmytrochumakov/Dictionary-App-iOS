//
//  MDAuthManager.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.08.2021.
//

import Foundation

protocol MDAuthManagerProtocol {
    
    func login(authRequest: AuthRequest,
               completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
    
    func register(authRequest: AuthRequest,
                  completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
    
}

final class MDAuthManager: MDAuthManagerProtocol {
    
    fileprivate let apiAuth: MDAPIAuthProtocol
    fileprivate var appSettings: MDAppSettingsProtocol
    
    init(apiAuth: MDAPIAuthProtocol,
         appSettings: MDAppSettingsProtocol) {
        
        self.apiAuth = apiAuth
        self.appSettings = appSettings
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDAuthManager {
    
    func login(authRequest: AuthRequest,
               completionHandler: @escaping(MDOperationResultWithCompletion<Void>)) {
        
        apiAuth.login(authRequest: authRequest) { [unowned self] loginResult in
            
            switch loginResult {
            
            case .success(let authResponse):
                
                break
                
            case .failure(let error):
                //
                completionHandler(.failure(error))
                //
                break
            //
            }
            
        }
        
    }
    
    func register(authRequest: AuthRequest,
                  completionHandler: @escaping(MDOperationResultWithCompletion<Void>)) {
        
        apiAuth.register(authRequest: authRequest) { [unowned self] registerResult in
            
            switch registerResult {
            
            case .success(let authResponse):
                //
               
                //
                break
            //
            case .failure(let error):
                //
                completionHandler(.failure(error))
                //
                break
            //
            }
            
        }
        
    }
    
}

fileprivate extension MDAuthManager {
    
    func setIsLoggedInIntoTrue() {
        appSettings.setIsLoggedTrue()
    }
    
}
