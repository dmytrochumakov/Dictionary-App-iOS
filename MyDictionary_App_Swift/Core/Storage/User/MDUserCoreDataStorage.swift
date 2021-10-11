//
//  MDUserCoreDataStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation
import CoreData

protocol MDUserCoreDataStorageProtocol: MDCRUDUserProtocol,
                                        MDStorageInterface {
    
}

final class MDUserCoreDataStorage: NSObject,
                                   MDUserCoreDataStorageProtocol {
    
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
extension MDUserCoreDataStorage {
    
    func entitiesIsEmpty(_ completionHandler: @escaping (MDEntitiesIsEmptyResultWithCompletion)) {
        self.readAllUsers() { result in
            switch result {
            case .success(let entities):
                completionHandler(.success(entities.isEmpty))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func entitiesCount(_ completionHandler: @escaping (MDEntitiesCountResultWithCompletion)) {
        self.readAllUsers() { result in
            switch result {
            case .success(let entities):
                completionHandler(.success(entities.count))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}

// MARK: - Create
extension MDUserCoreDataStorage {
    
    func createUser(_ userEntity: UserResponse,
                    password: String,
                    _ completionHandler: @escaping(MDOperationResultWithCompletion<UserResponse>)) {
        
        let operation: BlockOperation = .init {
            
            let newUser = userEntity.cdUserResponseEntity(password: password,
                                                          context: self.managedObjectContext)
            
            self.coreDataStack.save(managedObjectContext: self.managedObjectContext) { result in
                
                switch result {
                    
                case .success:
                    
                    //
                    completionHandler(.success(newUser.userResponse))
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
extension MDUserCoreDataStorage {
    
    func readUser(fromUserID userId: Int64,
                  _ completionHandler: @escaping(MDOperationResultWithCompletion<UserResponse>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<CDUserResponseEntity>(entityName: CoreDataEntityName.CDUserResponseEntity)
            fetchRequest.predicate = NSPredicate(format: "\(CDUserResponseEntityAttributeName.userId) == %i", userId)
            
            do {
                if let result = try self.managedObjectContext.fetch(fetchRequest).map({ $0.userResponse }).first {
                    
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
    
    func readFirstUser(_ completionHandler: @escaping (MDOperationResultWithCompletion<UserResponse>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<CDUserResponseEntity>(entityName: CoreDataEntityName.CDUserResponseEntity)
            
            do {
                if let result = try self.managedObjectContext.fetch(fetchRequest).map({ $0.userResponse }).first {
                    
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
    
    func readAllUsers(_ completionHandler: @escaping(MDOperationsResultWithCompletion<UserResponse>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<CDUserResponseEntity>(entityName: CoreDataEntityName.CDUserResponseEntity)
            
            do {
                
                //
                completionHandler(.success(try self.managedObjectContext.fetch(fetchRequest).map({ $0.userResponse })))
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

// MARK: - Delete
extension MDUserCoreDataStorage {
    
    func deleteUser(_ userId: Int64,
                    _ completionHandler: @escaping(MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityName.CDUserResponseEntity)
            fetchRequest.predicate = NSPredicate(format: "\(CDUserResponseEntityAttributeName.userId) == %i", userId)
            
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
    
    func deleteAllUsers(_ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityName.CDUserResponseEntity)
            
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
