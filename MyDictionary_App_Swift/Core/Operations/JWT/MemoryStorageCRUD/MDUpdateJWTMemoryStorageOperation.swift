//
//  MDUpdateJWTMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

final class MDUpdateJWTMemoryStorageOperation: MDOperation {
    
    fileprivate let memoryStorage: MDJWTMemoryStorage
    fileprivate let oldAccessToken: String
    fileprivate let newAuthResponse: AuthResponse
    fileprivate let result: MDEntityResult<AuthResponse>?
    
    init(memoryStorage: MDJWTMemoryStorage,
         oldAccessToken: String,
         newAuthResponse: AuthResponse,
         result: MDEntityResult<AuthResponse>?) {
        
        self.memoryStorage = memoryStorage
        self.oldAccessToken = oldAccessToken
        self.newAuthResponse = newAuthResponse
        self.result = result
        
        super.init()
    }
    
    override func main() {
        guard let authResponse = self.memoryStorage.authResponse,
              authResponse.accessToken == self.oldAccessToken
        else {
            self.result?(.failure(MDJWTOperationError.cantFindAuthResponse));
            self.finish();
            return
        }
        self.memoryStorage.authResponse = self.newAuthResponse
        self.result?(.success(self.newAuthResponse))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
