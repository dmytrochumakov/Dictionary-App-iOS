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
    fileprivate let wordId: Int64
    fileprivate let newWordText: String
    fileprivate let newWordDescription: String
    fileprivate let result: MDEntityResult<WordEntity>?
    
    init(managedObjectContext: NSManagedObjectContext,
         wordStorage: MDWordCoreDataStorage,
         wordId: Int64,
         newWordText: String,
         newWordDescription: String,
         result: MDEntityResult<WordEntity>?) {
        
        self.managedObjectContext = managedObjectContext
        self.wordStorage = wordStorage
        self.wordId = wordId
        self.newWordText = newWordText
        self.newWordDescription = newWordDescription
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        let batchUpdateRequest = NSBatchUpdateRequest(entityName: CoreDataEntityName.CDWordEntity)
        
        batchUpdateRequest.propertiesToUpdate = [CDWordEntityAttributeName.wordText : self.newWordText,
                                                 CDWordEntityAttributeName.wordDescription : self.newWordDescription
        ]
        
        batchUpdateRequest.predicate = NSPredicate(format: "\(CDWordEntityAttributeName.wordId) == %i", self.wordId)
        
        do {
            
            try managedObjectContext.execute(batchUpdateRequest)
            
            self.wordStorage.savePerform(wordId: self.wordId) { [weak self] (result) in
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
