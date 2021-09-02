//
//  MDAuthManager.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.08.2021.
//

import Foundation

protocol MDAuthManagerProtocol {
    
    func login(authRequest: AuthRequest,
               progressCompletionHandler: @escaping(MDProgressWithCompletion),
               completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
    
    func register(authRequest: AuthRequest,
                  progressCompletionHandler: @escaping(MDProgressWithCompletion),
                  completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
    
}

final class MDAuthManager: MDAuthManagerProtocol {
    
    fileprivate let apiAuth: MDAPIAuthProtocol
    fileprivate var appSettings: AppSettingsProtocol
    fileprivate let syncManager: MDSyncManagerProtocol
    
    init(apiAuth: MDAPIAuthProtocol,
         appSettings: AppSettingsProtocol,
         syncManager: MDSyncManagerProtocol) {
        
        self.apiAuth = apiAuth
        self.appSettings = appSettings
        self.syncManager = syncManager
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDAuthManager {
    
    func login(authRequest: AuthRequest,
               progressCompletionHandler: @escaping(MDProgressWithCompletion),
               completionHandler: @escaping(MDOperationResultWithCompletion<Void>)) {
        
        apiAuth.login(authRequest: authRequest) { [unowned self] loginResult in
            
            switch loginResult {
            
            case .success(let authResponse):
                
                syncManager.startFullSync(withSyncItem: .init(accessToken: authResponse.jwtResponse.accessToken,
                                                              password: authRequest.password,
                                                              userId: authResponse.userResponse.userId,
                                                              nickname: authRequest.nickname)) { progress in
                    // Pass progress
                    progressCompletionHandler(progress)
                    
                } completionHandler: { [unowned self] (syncResult) in
                    
                    switch syncResult {
                    
                    case .success:
                        // Set Is Logged In
                        setIsLoggedInIntoTrue()
                        //
                        completionHandler(.success(()))
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
                  progressCompletionHandler: @escaping(MDProgressWithCompletion),
                  completionHandler: @escaping(MDOperationResultWithCompletion<Void>)) {
        
        apiAuth.register(authRequest: authRequest) { [unowned self] registerResult in
            
            switch registerResult {
            
            case .success(let authResponse):
                //
                syncManager.startWithJWTAndUserAndLanguageSync(withSyncItem: .init(accessToken: authResponse.jwtResponse.accessToken,
                                                                                   password: authRequest.password,
                                                                                   userId: authResponse.userResponse.userId,
                                                                                   nickname: authRequest.nickname)) { progress in
                    // Pass progress
                    progressCompletionHandler(progress)
                    
                } completionHandler: { [unowned self] (syncResult) in
                    
                    switch syncResult {
                    
                    case .success:
                        // Set Is Logged In
                        setIsLoggedInIntoTrue()
                        //
                        completionHandler(.success(()))
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
        appSettings.isLoggedIn = true
    }
    
}
