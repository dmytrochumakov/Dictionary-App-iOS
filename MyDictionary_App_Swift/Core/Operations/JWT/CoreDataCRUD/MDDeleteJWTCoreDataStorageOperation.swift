//
//  MDDeleteJWTCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.08.2021.
//

import CoreData

final class MDDeleteJWTCoreDataStorageOperation: MDOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStorage: MDJWTCoreDataStorage
    fileprivate let jwtResponse: JWTResponse
    fileprivate let result: MDOperationResultWithCompletion<JWTResponse>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStorage: MDJWTCoreDataStorage,
         jwtResponse: JWTResponse,
         result: MDOperationResultWithCompletion<JWTResponse>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStorage = coreDataStorage
        self.jwtResponse = jwtResponse
        self.result = result
        
        super.init()
        
    }
    
    override func main() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityName.CDJWTResponseEntity)
        fetchRequest.predicate = NSPredicate(format: "\(CDJWTResponseEntityAttributeName.accessToken) == %@", jwtResponse.accessToken)
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            
            try managedObjectContext.execute(batchDeleteRequest)
            
            self.coreDataStorage.savePerform { [weak self] (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        guard let self = self
                        else {
                            self?.result?(.failure(MDEntityOperationError.objectRemovedFromMemory));
                            self?.finish() ;
                            return
                        }
                        self.result?(.success(self.jwtResponse))
                        self.finish()
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
