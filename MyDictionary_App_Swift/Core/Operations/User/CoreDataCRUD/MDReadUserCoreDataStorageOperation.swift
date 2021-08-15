//
//  MDReadUserCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import CoreData

final class MDReadUserCoreDataStorageOperation: MDOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStorage: MDUserCoreDataStorage
    fileprivate let userId: Int64
    fileprivate let result: MDEntityResult<UserEntity>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStorage: MDUserCoreDataStorage,
         userId: Int64,
         result: MDEntityResult<UserEntity>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStorage = coreDataStorage
        self.userId = userId
        self.result = result
        
        super.init()
        
    }
    
    override func main() {
        
        let fetchRequest = NSFetchRequest<CDUserEntity>(entityName: CoreDataEntityName.CDUserEntity)
        fetchRequest.predicate = NSPredicate(format: "\(CDUserEntityAttributeName.userId) == %i", userId)
        
        let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { [weak self] asynchronousFetchResult in
            
            if let result = asynchronousFetchResult.finalResult {
                if let user = result.map({ $0.userEntity }).first {
                    DispatchQueue.main.async {
                        self?.result?(.success(user))
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
