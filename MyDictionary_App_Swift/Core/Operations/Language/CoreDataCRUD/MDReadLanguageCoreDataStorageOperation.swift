//
//  MDReadLanguageCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import CoreData

final class MDReadLanguageCoreDataStorageOperation: MDAsyncOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStorage: MDLanguageCoreDataStorage
    fileprivate let languageId: Int64
    fileprivate let result: MDOperationResultWithCompletion<LanguageResponse>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStorage: MDLanguageCoreDataStorage,
         languageId: Int64,
         result: MDOperationResultWithCompletion<LanguageResponse>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStorage = coreDataStorage
        self.languageId = languageId
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        let fetchRequest = NSFetchRequest<CDLanguageResponseEntity>(entityName: CoreDataEntityName.CDLanguageResponseEntity)
        fetchRequest.predicate = NSPredicate(format: "\(CDLanguageResponseEntityAttributeName.languageId) == %i", languageId)
               
        do {
            if let result = try managedObjectContext.fetch(fetchRequest).map({ $0.languageResponse }).first {
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
