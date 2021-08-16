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
    fileprivate let jwtResponse: JWTResponse
    fileprivate let result: MDEntityResult<JWTResponse>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStorage: MDJWTCoreDataStorage,
         jwtResponse: JWTResponse,
         result: MDEntityResult<JWTResponse>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStorage = coreDataStorage
        self.jwtResponse = jwtResponse
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        let newAuthResponse = CDJWTResponseEntity.init(jwtResponse: self.jwtResponse,
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
