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
    fileprivate let wordId: Int64
    fileprivate let result: MDOperationResultWithCompletion<WordResponse>?
    
    init(managedObjectContext: NSManagedObjectContext,
         wordStorage: MDWordCoreDataStorage,
         wordId: Int64,
         result: MDOperationResultWithCompletion<WordResponse>?) {
        
        self.managedObjectContext = managedObjectContext
        self.wordStorage = wordStorage
        self.wordId = wordId
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        let fetchRequest = NSFetchRequest<CDWordResponseEntity>(entityName: CoreDataEntityName.CDWordResponseEntity)
        fetchRequest.predicate = NSPredicate(format: "\(CDWordResponseEntityAttributeName.wordId) == %i", wordId)
        
        do {
            if let result = try managedObjectContext.fetch(fetchRequest).map({ $0.wordResponse }).first {
                self.result?(.success(result))
                self.finish()
            } else {
                self.result?(.failure(MDEntityOperationError.cantFindEntity))
                self.finish()
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

final class MDReadWordsCoreDataStorageOperation: MDOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let wordStorage: MDWordCoreDataStorage
    fileprivate let fetchLimit: Int
    fileprivate let fetchOffset: Int
    fileprivate let result: MDOperationsResultWithCompletion<WordResponse>?
    
    init(managedObjectContext: NSManagedObjectContext,
         wordStorage: MDWordCoreDataStorage,
         fetchLimit: Int,
         fetchOffset: Int,
         result: MDOperationsResultWithCompletion<WordResponse>?) {
        
        self.managedObjectContext = managedObjectContext
        self.wordStorage = wordStorage
        self.fetchLimit = fetchLimit
        self.fetchOffset = fetchOffset
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        let fetchRequest = NSFetchRequest<CDWordResponseEntity>(entityName: CoreDataEntityName.CDWordResponseEntity)
        
        fetchRequest.fetchLimit = self.fetchLimit
        fetchRequest.fetchOffset = self.fetchOffset
        
        do {
            self.result?(.success(try managedObjectContext.fetch(fetchRequest).map({ $0.wordResponse })))
            self.finish()
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

final class MDReadAllWordsByCourseIDCoreDataStorageOperation: MDOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let wordStorage: MDWordCoreDataStorage
    fileprivate let courseId: Int64
    fileprivate let result: MDOperationsResultWithCompletion<WordResponse>?
    
    init(managedObjectContext: NSManagedObjectContext,
         wordStorage: MDWordCoreDataStorage,
         courseId: Int64,
         result: MDOperationsResultWithCompletion<WordResponse>?) {
        
        self.managedObjectContext = managedObjectContext
        self.wordStorage = wordStorage
        self.courseId = courseId
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        let fetchRequest = NSFetchRequest<CDWordResponseEntity>(entityName: CoreDataEntityName.CDWordResponseEntity)
        fetchRequest.predicate = NSPredicate(format: "\(CDWordResponseEntityAttributeName.courseId) == %i", self.courseId)
        
        do {
            self.result?(.success(try managedObjectContext.fetch(fetchRequest).map({ $0.wordResponse })))
            self.finish()
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
