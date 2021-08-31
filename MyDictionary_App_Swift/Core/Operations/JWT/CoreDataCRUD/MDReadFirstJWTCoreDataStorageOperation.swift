//
//  MDReadFirstJWTCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.08.2021.
//

import CoreData

final class MDReadFirstJWTCoreDataStorageOperation: MDOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStorage: MDJWTCoreDataStorage
    fileprivate let result: MDOperationResultWithCompletion<JWTResponse>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStorage: MDJWTCoreDataStorage,
         result: MDOperationResultWithCompletion<JWTResponse>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStorage = coreDataStorage
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        let fetchRequest = NSFetchRequest<CDJWTResponseEntity>(entityName: CoreDataEntityName.CDJWTResponseEntity)
        
        let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { [weak self] asynchronousFetchResult in
            
            if let result = asynchronousFetchResult.finalResult {
                DispatchQueue.main.async {
                    
                    guard let firstResult = result.first else {
                        self?.result?(.failure(MDEntityOperationError.cantFindEntity))
                        return
                    }
                    
                    self?.result?(.success(firstResult.jwtResponse))
                    self?.finish()
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

