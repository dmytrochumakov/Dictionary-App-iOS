//
//  MDReadUsersCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import CoreData

final class MDReadUsersCoreDataStorageOperation: MDAsyncOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStorage: MDUserCoreDataStorage
    fileprivate let result: MDOperationsResultWithCompletion<UserResponse>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStorage: MDUserCoreDataStorage,
         result: MDOperationsResultWithCompletion<UserResponse>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStorage = coreDataStorage
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        let fetchRequest = NSFetchRequest<CDUserResponseEntity>(entityName: CoreDataEntityName.CDUserResponseEntity)
        
        do {
            self.result?(.success(try managedObjectContext.fetch(fetchRequest).map({ $0.userResponse })))
            self.finish()
        } catch {
            self.result?(.failure(error))
            self.finish()            
        }
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
