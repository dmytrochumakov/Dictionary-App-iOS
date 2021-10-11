//
//  MDJWTCoreDataStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation
import CoreData

protocol MDJWTCoreDataStorageProtocol: MDCRUDJWTProtocol,
                                       MDStorageInterface {
    
}

final class MDJWTCoreDataStorage: NSObject,
                                  MDJWTCoreDataStorageProtocol {
    
    fileprivate let operationQueue: OperationQueue
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStack: MDCoreDataStack
    
    init(operationQueue: OperationQueue,
         managedObjectContext: NSManagedObjectContext,
         coreDataStack: MDCoreDataStack) {
        
        self.operationQueue = operationQueue
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Entities
extension MDJWTCoreDataStorage {
    
    func entitiesCount(_ completionHandler: @escaping(MDEntitiesCountResultWithCompletion)) {
        self.readAllJWTs() { result in
            switch result {
            case .success(let entities):
                completionHandler(.success(entities.count))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func entitiesIsEmpty(_ completionHandler: @escaping(MDEntitiesIsEmptyResultWithCompletion)) {
        self.readAllJWTs() { result in
            switch result {
            case .success(let entities):
                completionHandler(.success(entities.isEmpty))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}

// MARK: - Create
extension MDJWTCoreDataStorage {
    
    func createJWT(_ jwtResponse: JWTResponse,
                   _ completionHandler: @escaping(MDOperationResultWithCompletion<JWTResponse>)) {
        
        let operation: BlockOperation = .init {
            
            let newJWTResponse = jwtResponse.cdJWTResponseEntity(context: self.managedObjectContext)
            
            self.coreDataStack.save(managedObjectContext: self.managedObjectContext) { result in
                
                switch result {
                    
                case .success:
                    
                    //
                    completionHandler(.success(newJWTResponse.jwtResponse))
                    //
                    
                    //
                    break
                    //
                    
                case .failure(let error):
                    
                    //
                    completionHandler(.failure(error))
                    //
                    
                    //
                    break
                    //
                    
                }
                
            }
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
}

// MARK: - Read
extension MDJWTCoreDataStorage {
    
    func readJWT(fromAccessToken accessToken: String,
                 _ completionHandler: @escaping(MDOperationResultWithCompletion<JWTResponse>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<CDJWTResponseEntity>(entityName: CoreDataEntityName.CDJWTResponseEntity)
            fetchRequest.predicate = NSPredicate(format: "\(CDJWTResponseEntityAttributeName.accessToken) == %@", accessToken)
            
            do {
                if let result = try self.managedObjectContext.fetch(fetchRequest).map({ $0.jwtResponse }).first {
                    
                    //
                    completionHandler(.success(result))
                    //
                    
                    //
                    return
                    //
                    
                } else {
                    
                    //
                    completionHandler(.failure(MDEntityOperationError.cantFindEntity))
                    //
                    
                    //
                    return
                    //
                    
                }
            } catch {
                
                //
                completionHandler(.failure(error))
                //
                
                
                //
                return
                //
                
            }
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
    func readFirstJWT(_ completionHandler: @escaping (MDOperationResultWithCompletion<JWTResponse>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<CDJWTResponseEntity>(entityName: CoreDataEntityName.CDJWTResponseEntity)
            
            do {
                if let result = try self.managedObjectContext.fetch(fetchRequest).map({ $0.jwtResponse }).first {
                    
                    //
                    completionHandler(.success(result))
                    //
                    
                    //
                    return
                    //
                    
                } else {
                    
                    //
                    completionHandler(.failure(MDEntityOperationError.cantFindEntity))
                    //
                    
                    //
                    return
                    //
                    
                }
            } catch {
                
                //
                completionHandler(.failure(error))
                //
                
                //
                return
                //
                
            }
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
    func readAllJWTs(_ completionHandler: @escaping (MDOperationsResultWithCompletion<JWTResponse>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<CDJWTResponseEntity>(entityName: CoreDataEntityName.CDJWTResponseEntity)
            
            do {
                
                //
                completionHandler(.success(try self.managedObjectContext.fetch(fetchRequest).map({ $0.jwtResponse })))
                //
                
                //
                return
                //
                
            } catch {
                
                //
                completionHandler(.failure(error))
                //
                
                //
                return
                //
                
            }
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
}


// MARK: - Update
extension MDJWTCoreDataStorage {
    
    func updateJWT(oldAccessToken accessToken: String,
                   newJWTResponse jwtResponse: JWTResponse,
                   _ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            let batchUpdateRequest = NSBatchUpdateRequest(entityName: CoreDataEntityName.CDJWTResponseEntity)
            batchUpdateRequest.propertiesToUpdate = [CDJWTResponseEntityAttributeName.accessToken : jwtResponse.accessToken,
                                                     CDJWTResponseEntityAttributeName.expirationDate : jwtResponse.expirationDate
            ]
            
            batchUpdateRequest.predicate = NSPredicate(format: "\(CDJWTResponseEntityAttributeName.accessToken) == %@", accessToken)
            
            do {
                
                try self.managedObjectContext.execute(batchUpdateRequest)
                
                self.coreDataStack.save(managedObjectContext: self.managedObjectContext) { result in
                    
                    switch result {
                        
                    case .success:
                        
                        //
                        completionHandler(.success(()))
                        //
                        
                        //
                        break
                        //
                        
                    case .failure(let error):
                        
                        //
                        completionHandler(.failure(error))
                        //
                        
                        //
                        break
                        //
                        
                    }
                    
                }
                
            } catch {
                
                //
                completionHandler(.failure(error))
                //
                
                //
                return
                //
                
            }
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
}

// MARK: - Delete
extension MDJWTCoreDataStorage {
    
    func deleteJWT(_ byAccessToken: String,
                   _ completionHandler: @escaping(MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityName.CDJWTResponseEntity)
            fetchRequest.predicate = NSPredicate(format: "\(CDJWTResponseEntityAttributeName.accessToken) == %@", byAccessToken)
            
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                
                try self.managedObjectContext.execute(batchDeleteRequest)
                
                self.coreDataStack.save(managedObjectContext: self.managedObjectContext) { result in
                    
                    switch result {
                        
                    case .success:
                        
                        //
                        completionHandler(.success(()))
                        //
                        
                        //
                        break
                        //
                        
                    case .failure(let error):
                        
                        //
                        completionHandler(.failure(error))
                        //
                        
                        //
                        break
                        //
                        
                    }
                    
                }
                
            } catch {
                
                //
                completionHandler(.failure(error))
                //
                
                //
                return
                //
                
            }
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
    func deleteAllJWT(_ completionHandler: @escaping(MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityName.CDJWTResponseEntity)
            
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                
                try self.managedObjectContext.execute(batchDeleteRequest)
                
                self.coreDataStack.save(managedObjectContext: self.managedObjectContext) { result in
                    
                    switch result {
                        
                    case .success:
                        
                        //
                        completionHandler(.success(()))
                        //
                        
                        //
                        break
                        //
                        
                    case .failure(let error):
                        
                        //
                        completionHandler(.failure(error))
                        //
                        
                        //
                        break
                        //
                        
                    }
                    
                }
                
            } catch {
                
                //
                completionHandler(.failure(error))
                //
                
                //
                return
                //
                
            }
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
}
