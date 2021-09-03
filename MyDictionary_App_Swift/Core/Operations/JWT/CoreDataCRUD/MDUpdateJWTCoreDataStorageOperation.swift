//
//  MDUpdateJWTCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.08.2021.
//

import CoreData

final class MDUpdateJWTCoreDataStorageOperation: MDOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStorage: MDJWTCoreDataStorage
    fileprivate let oldAccessToken: String
    fileprivate let newJWTResponse: JWTResponse
    fileprivate let result: MDOperationResultWithCompletion<Void>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStorage: MDJWTCoreDataStorage,
         oldAccessToken: String,
         newJWTResponse: JWTResponse,
         result: MDOperationResultWithCompletion<Void>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStorage = coreDataStorage
        self.oldAccessToken = oldAccessToken
        self.newJWTResponse = newJWTResponse
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        let batchUpdateRequest = NSBatchUpdateRequest(entityName: CoreDataEntityName.CDJWTResponseEntity)
        batchUpdateRequest.propertiesToUpdate = [CDJWTResponseEntityAttributeName.accessToken : self.newJWTResponse.accessToken,
                                                 CDJWTResponseEntityAttributeName.expirationDate : self.newJWTResponse.expirationDate
        ]
        
        batchUpdateRequest.predicate = NSPredicate(format: "\(CDJWTResponseEntityAttributeName.accessToken) == %@", self.oldAccessToken)
        
        do {
            
            try managedObjectContext.execute(batchUpdateRequest)
            
            CoreDataStack.savePerform(coreDataStack: coreDataStorage.coreDataStack) { [weak self] (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        self?.result?(.success(()))
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
