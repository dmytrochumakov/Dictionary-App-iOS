//
//  MDDeleteWordCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import Foundation
import CoreData

final class MDDeleteWordCoreDataStorageOperation: MDAsyncOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStack: MDCoreDataStack
    fileprivate let wordStorage: MDWordCoreDataStorage
    fileprivate let wordId: Int64
    fileprivate let result: MDOperationResultWithCompletion<Void>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStack: MDCoreDataStack,
         wordStorage: MDWordCoreDataStorage,
         wordId: Int64,
         result: MDOperationResultWithCompletion<Void>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
        self.wordStorage = wordStorage
        self.wordId = wordId
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityName.CDWordResponseEntity)
        
        fetchRequest.predicate = NSPredicate(format: "\(CDWordResponseEntityAttributeName.wordId) == %i", wordId)
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            
            try managedObjectContext.execute(batchDeleteRequest)
            
            coreDataStack.save(managedObjectContext: managedObjectContext) { [weak self] result in
                
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
