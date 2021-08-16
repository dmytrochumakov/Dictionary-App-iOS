//
//  MDReadJWTCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.08.2021.
//

import CoreData

final class MDReadJWTCoreDataStorageOperation: MDOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStorage: MDJWTCoreDataStorage
    fileprivate let accessToken: String
    fileprivate let result: MDEntityResult<AuthResponse>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStorage: MDJWTCoreDataStorage,
         accessToken: String,
         result: MDEntityResult<AuthResponse>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStorage = coreDataStorage
        self.accessToken = accessToken
        self.result = result
        
        super.init()
        
    }
    
    override func main() {
        
        let fetchRequest = NSFetchRequest<CDAuthResponseEntity>(entityName: CoreDataEntityName.CDAuthResponseEntity)
        fetchRequest.predicate = NSPredicate(format: "\(CDAuthResponseEntityAttributeName.accessToken) == %@", accessToken)
        
        let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { [weak self] asynchronousFetchResult in
            
            if let result = asynchronousFetchResult.finalResult {
                if let authResponse = result.map({ $0.authResponse }).first {
                    DispatchQueue.main.async {
                        self?.result?(.success(authResponse))
                        self?.finish()
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.result?(.failure(MDEntityOperationError.cantFindEntity))
                        self?.finish()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self?.result?(.failure(MDEntityOperationError.cantFindEntity))
                    self?.finish()
                }
            }
            
        }
        
        do {
            try managedObjectContext.execute(asynchronousFetchRequest)
        } catch let error {
            self.result?(.failure(error))
            self.finish()
        }
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}

