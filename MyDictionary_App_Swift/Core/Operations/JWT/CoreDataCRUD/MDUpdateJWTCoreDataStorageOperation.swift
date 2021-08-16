//
//  MDUpdateJWTCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.08.2021.
//

import CoreData

final class MDUpdateJWTCoreDataStorageOperation: MDOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStorage: MDJWTCoreDataStorage
    fileprivate let oldAccessToken: String
    fileprivate let newAuthResponse: AuthResponse
    fileprivate let result: MDEntityResult<AuthResponse>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStorage: MDJWTCoreDataStorage,
         oldAccessToken: String,
         newAuthResponse: AuthResponse,
         result: MDEntityResult<AuthResponse>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStorage = coreDataStorage
        self.oldAccessToken = oldAccessToken
        self.newAuthResponse = newAuthResponse
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        let batchUpdateRequest = NSBatchUpdateRequest(entityName: CoreDataEntityName.CDAuthResponseEntity)
        batchUpdateRequest.propertiesToUpdate = [CDAuthResponseEntityAttributeName.accessToken : self.newAuthResponse.accessToken,
                                                 CDAuthResponseEntityAttributeName.expirationDate : self.newAuthResponse.expirationDate
        ]
        
        batchUpdateRequest.predicate = NSPredicate(format: "\(CDAuthResponseEntityAttributeName.accessToken) == %@", self.oldAccessToken)
        
        do {
            
            try managedObjectContext.execute(batchUpdateRequest)
            
            self.coreDataStorage.savePerform(accessToken: self.newAuthResponse.accessToken) { [weak self] (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let updatedEntity):
                        self?.result?(.success(updatedEntity))
                        self?.finish()
                    case .failure(let error):
                        self?.result?(.failure(error))
                        self?.finish()
                    }
                }
            }
            
        } catch let error {
            DispatchQueue.main.async {
                self.result?(.failure(error))
                self.finish()
            }
        }
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
