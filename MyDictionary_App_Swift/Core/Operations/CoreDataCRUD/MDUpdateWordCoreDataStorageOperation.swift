//
//  MDUpdateWordCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import Foundation
import CoreData

final class MDUpdateWordCoreDataStorageOperation: MDWordOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let wordStorage: MDWordCoreDataStorage
    fileprivate let uuid: UUID
    fileprivate let word: String
    fileprivate let wordDescription: String
    fileprivate let result: MDUpdateWordOperationResult?
    
    init(managedObjectContext: NSManagedObjectContext,
         wordStorage: MDWordCoreDataStorage,
         uuid: UUID,
         word: String,
         wordDescription: String,
         result: MDUpdateWordOperationResult?) {
        
        self.managedObjectContext = managedObjectContext
        self.wordStorage = wordStorage
        self.uuid = uuid
        self.word = word
        self.wordDescription = wordDescription
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        let batchUpdateRequest = NSBatchUpdateRequest(entityName: CoreDataEntityName.CDWordEntity)
        batchUpdateRequest.propertiesToUpdate = [CDWordEntityAttributeName.word : self.word,
                                                 CDWordEntityAttributeName.wordDescription : self.wordDescription
        ]
        batchUpdateRequest.predicate = NSPredicate(format: "\(CDWordEntityAttributeName.uuid) == %@", self.uuid.uuidString)
        
        do {
            try managedObjectContext.execute(batchUpdateRequest)
            self.wordStorage.savePerform(uuid: self.uuid) { [weak self] (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let updatedWord):
                        self?.result?(.success(updatedWord))
                        self?.finish()
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
        debugPrint(Self.self, #function)
        self.finish()
    }
    
}
