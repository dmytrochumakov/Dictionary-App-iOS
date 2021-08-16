//
//  MDCreateJWTCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.08.2021.
//

import Foundation
import CoreData

final class MDCreateJWTCoreDataStorageOperation: MDOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStorage: MDJWTCoreDataStorage
    fileprivate let authResponse: AuthResponse
    fileprivate let result: MDEntityResult<AuthResponse>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStorage: MDJWTCoreDataStorage,
         authResponse: AuthResponse,
         result: MDEntityResult<AuthResponse>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStorage = coreDataStorage
        self.authResponse = authResponse
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        let newAuthResponse = CDAuthResponseEntity.init(authResponse: self.authResponse,
                                                        insertIntoManagedObjectContext: self.managedObjectContext)
        
        self.coreDataStorage.save(accessToken: newAuthResponse.accessToken!) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let createdJWT):
                    self?.result?(.success(createdJWT))
                    self?.finish()
                case .failure(let error):
                    self?.result?(.failure(error))
                    self?.finish()
                }
            }
        }
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
