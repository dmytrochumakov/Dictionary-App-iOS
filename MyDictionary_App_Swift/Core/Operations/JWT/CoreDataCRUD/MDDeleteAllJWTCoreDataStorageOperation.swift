//
//  MDDeleteAllJWTCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import CoreData

final class MDDeleteAllJWTCoreDataStorageOperation: MDOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStorage: MDJWTCoreDataStorage
    fileprivate let result: MDOperationResultWithCompletion<Void>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStorage: MDJWTCoreDataStorage,
         result: MDOperationResultWithCompletion<Void>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStorage = coreDataStorage
        self.result = result
        
        super.init()
        
    }
    
    override func main() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityName.CDJWTResponseEntity)
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            
            try managedObjectContext.execute(batchDeleteRequest)
            
            CoreDataStack.savePerform(coreDataStack: coreDataStorage.coreDataStack) { [unowned self] (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        self.result?(.success(()))
                        self.finish()
                    case .failure(let error):
                        self.result?(.failure(error))
                        self.finish()
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
