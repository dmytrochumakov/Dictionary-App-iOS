//
//  MDReadWordCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import Foundation
import CoreData

final class MDReadWordCoreDataStorageOperation: MDOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let wordStorage: MDWordCoreDataStorage
    fileprivate let id: Int64
    fileprivate let result: MDEntityResult<WordEntity>?
    
    init(managedObjectContext: NSManagedObjectContext,
         wordStorage: MDWordCoreDataStorage,
         id: Int64,
         result: MDEntityResult<WordEntity>?) {
        
        self.managedObjectContext = managedObjectContext
        self.wordStorage = wordStorage
        self.id = id
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        let fetchRequest = NSFetchRequest<CDWordEntity>(entityName: CoreDataEntityName.CDWordEntity)
        fetchRequest.predicate = NSPredicate(format: "\(CDWordEntityAttributeName.id) == %i", id)
        let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { [weak self] asynchronousFetchResult in
            
            if let result = asynchronousFetchResult.finalResult {
                if let word = result.map({ $0.wordModel }).first {
                    DispatchQueue.main.async {
                        self?.result?(.success(word))
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

final class MDReadWordsCoreDataStorageOperation: MDOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let wordStorage: MDWordCoreDataStorage
    fileprivate let fetchLimit: Int
    fileprivate let fetchOffset: Int
    fileprivate let result: MDEntitiesResult<WordEntity>?
    
    init(managedObjectContext: NSManagedObjectContext,
         wordStorage: MDWordCoreDataStorage,
         fetchLimit: Int,
         fetchOffset: Int,
         result: MDEntitiesResult<WordEntity>?) {
        
        self.managedObjectContext = managedObjectContext
        self.wordStorage = wordStorage
        self.fetchLimit = fetchLimit
        self.fetchOffset = fetchOffset
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        let fetchRequest = NSFetchRequest<CDWordEntity>(entityName: CoreDataEntityName.CDWordEntity)
        fetchRequest.fetchLimit = self.fetchLimit
        fetchRequest.fetchOffset = self.fetchOffset
        let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { [weak self] asynchronousFetchResult in
            
            if let result = asynchronousFetchResult.finalResult {
                DispatchQueue.main.async {
                    self?.result?(.success(result.map({ $0.wordModel })))
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
