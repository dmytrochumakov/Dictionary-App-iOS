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
    fileprivate let wordStorage: MDWordCoreDataStorage
    fileprivate let id: Int64
    fileprivate let word: String
    fileprivate let word_description: String
    fileprivate let result: MDUpdateWordOperationResult?
    
    init(managedObjectContext: NSManagedObjectContext,
         wordStorage: MDWordCoreDataStorage,
         id: Int64,
         word: String,
         word_description: String,
         result: MDUpdateWordOperationResult?) {
        
        self.managedObjectContext = managedObjectContext
        self.wordStorage = wordStorage
        self.id = id
        self.word = word
        self.word_description = word_description
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        let batchUpdateRequest = NSBatchUpdateRequest(entityName: CoreDataEntityName.CDWordEntity)
        batchUpdateRequest.propertiesToUpdate = [CDWordEntityAttributeName.word : self.word,
                                                 CDWordEntityAttributeName.word_description : self.word_description
        ]
        batchUpdateRequest.predicate = NSPredicate(format: "\(CDWordEntityAttributeName.id) == %i", self.id)
        
        do {
            try managedObjectContext.execute(batchUpdateRequest)
            self.wordStorage.savePerform(id: self.id) { [weak self] (result) in
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
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
