//
//  MDReadJWTCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.08.2021.
//

import CoreData

final class MDReadJWTCoreDataStorageOperation: MDAsyncOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStorage: MDJWTCoreDataStorage
    fileprivate let accessToken: String
    fileprivate let result: MDOperationResultWithCompletion<JWTResponse>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStorage: MDJWTCoreDataStorage,
         accessToken: String,
         result: MDOperationResultWithCompletion<JWTResponse>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStorage = coreDataStorage
        self.accessToken = accessToken
        self.result = result
        
        super.init()
        
    }
    
    override func main() {
        
        let fetchRequest = NSFetchRequest<CDJWTResponseEntity>(entityName: CoreDataEntityName.CDJWTResponseEntity)
        fetchRequest.predicate = NSPredicate(format: "\(CDJWTResponseEntityAttributeName.accessToken) == %@", accessToken)
                
        do {
            if let result = try managedObjectContext.fetch(fetchRequest).map({ $0.jwtResponse }).first {
                self.result?(.success(result))
                self.finish()
            } else {
                self.result?(.failure(MDEntityOperationError.cantFindEntity))
                self.finish()
            }
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
