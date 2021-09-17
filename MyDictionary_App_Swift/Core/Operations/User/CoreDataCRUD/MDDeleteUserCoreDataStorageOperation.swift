//
//  MDDeleteUserCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import CoreData

final class MDDeleteUserCoreDataStorageOperation: MDOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStack: MDCoreDataStack
    fileprivate let coreDataStorage: MDUserCoreDataStorage
    fileprivate let userId: Int64
    fileprivate let result: MDOperationResultWithCompletion<Void>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStack: MDCoreDataStack,
         coreDataStorage: MDUserCoreDataStorage,
         userId: Int64,
         result: MDOperationResultWithCompletion<Void>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
        self.coreDataStorage = coreDataStorage
        self.userId = userId
        self.result = result
        
        super.init()
        
    }
    
    override func main() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityName.CDUserResponseEntity)
        fetchRequest.predicate = NSPredicate(format: "\(CDUserResponseEntityAttributeName.userId) == %i", userId)
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            
            try managedObjectContext.execute(batchDeleteRequest)
            
            coreDataStack.save(context: self.managedObjectContext) { [weak self] result in
                
                switch result {
                
                case .success:
                    
                    self?.result?(.success(()))
                    self?.finish()
                    break
                    
                case .failure(let error):
                    
                    self?.result?(.failure(error))
                    self?.finish()
                    break
                    
                }
                
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

final class MDDeleteAllUsersCoreDataStorageOperation: MDOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStack: MDCoreDataStack
    fileprivate let coreDataStorage: MDUserCoreDataStorage
    fileprivate let result: MDOperationResultWithCompletion<Void>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStack: MDCoreDataStack,
         coreDataStorage: MDUserCoreDataStorage,
         result: MDOperationResultWithCompletion<Void>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
        self.coreDataStorage = coreDataStorage
        self.result = result
        
        super.init()
        
    }
    
    override func main() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityName.CDUserResponseEntity)
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            
            try managedObjectContext.execute(batchDeleteRequest)
            
            coreDataStack.save(context: self.managedObjectContext) { [weak self] result in
                
                switch result {
                
                case .success:
                    
                    self?.result?(.success(()))
                    self?.finish()
                    break
                    
                case .failure(let error):
                    
                    self?.result?(.failure(error))
                    self?.finish()
                    break
                    
                }
                
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
