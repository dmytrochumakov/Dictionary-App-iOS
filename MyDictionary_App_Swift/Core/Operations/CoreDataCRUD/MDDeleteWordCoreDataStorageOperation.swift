//
//  MDDeleteWordCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import Foundation
import CoreData

final class MDDeleteWordCoreDataStorageOperation: MDOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let wordStorage: MDWordCoreDataStorage
    fileprivate let word: WordModel
    fileprivate let result: MDDeleteWordOperationResult?
    
    init(managedObjectContext: NSManagedObjectContext,
         wordStorage: MDWordCoreDataStorage,
         word: WordModel,
         result: MDDeleteWordOperationResult?) {
        
        self.managedObjectContext = managedObjectContext
        self.wordStorage = wordStorage
        self.word = word
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityName.CDWordEntity)
        fetchRequest.predicate = NSPredicate(format: "\(CDWordEntityAttributeName.id) == %i", word.id)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedObjectContext.execute(batchDeleteRequest)
            self.wordStorage.savePerform { [weak self] (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        guard let self = self
                        else {
                            self?.result?(.failure(MDWordOperationError.objectRemovedFromMemory));
                            self?.finish() ;
                            return
                        }
                        self.result?(.success(self.word))
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
