//
//  MDReadUsersCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import CoreData

final class MDReadUsersCoreDataStorageOperation: MDOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStorage: MDUserCoreDataStorage
    fileprivate let result: MDEntitiesResult<UserEntity>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStorage: MDUserCoreDataStorage,
         result: MDEntitiesResult<UserEntity>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStorage = coreDataStorage
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        let fetchRequest = NSFetchRequest<CDUserEntity>(entityName: CoreDataEntityName.CDUserEntity)
        
        let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { [weak self] asynchronousFetchResult in
            
            if let result = asynchronousFetchResult.finalResult {
                DispatchQueue.main.async {
                    self?.result?(.success(result.map({ $0.userEntity })))
                    self?.finish()
                }
            } else {
                DispatchQueue.main.async {
                    self?.result?(.failure(MDUserOperationError.cantFindUser))
                    self?.finish()
                }
            }
            
        }
        
        do {
            try managedObjectContext.execute(asynchronousFetchRequest)
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

