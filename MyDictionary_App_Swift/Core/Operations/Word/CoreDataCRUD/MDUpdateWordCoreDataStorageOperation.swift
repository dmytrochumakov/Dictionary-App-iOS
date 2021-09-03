//
//  MDUpdateWordCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import Foundation
import CoreData

final class MDUpdateWordCoreDataStorageOperation: MDOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStack: CoreDataStack
    fileprivate let wordStorage: MDWordCoreDataStorage
    fileprivate let wordId: Int64
    fileprivate let newWordText: String
    fileprivate let newWordDescription: String
    fileprivate let result: MDOperationResultWithCompletion<Void>?
    
    init(managedObjectContext: NSManagedObjectContext,
         wordStorage: MDWordCoreDataStorage,
         coreDataStack: CoreDataStack,
         wordId: Int64,
         newWordText: String,
         newWordDescription: String,
         result: MDOperationResultWithCompletion<Void>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
        self.wordStorage = wordStorage
        self.wordId = wordId
        self.newWordText = newWordText
        self.newWordDescription = newWordDescription
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        let batchUpdateRequest = NSBatchUpdateRequest(entityName: CoreDataEntityName.CDWordResponseEntity)
        
        batchUpdateRequest.propertiesToUpdate = [CDWordResponseEntityAttributeName.wordText : self.newWordText,
                                                 CDWordResponseEntityAttributeName.wordDescription : self.newWordDescription
        ]
        
        batchUpdateRequest.predicate = NSPredicate(format: "\(CDWordResponseEntityAttributeName.wordId) == %i", self.wordId)
        
        do {
            
            try managedObjectContext.execute(batchUpdateRequest)
            
            try coreDataStack.save()
            
            self.result?(.success(()))
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
