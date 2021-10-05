//
//  MDReadAllLanguagesCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import CoreData

final class MDReadAllLanguagesCoreDataStorageOperation: MDAsyncOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStorage: MDLanguageCoreDataStorage
    fileprivate let result: MDOperationsResultWithCompletion<LanguageResponse>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStorage: MDLanguageCoreDataStorage,
         result: MDOperationsResultWithCompletion<LanguageResponse>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStorage = coreDataStorage
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        let fetchRequest = NSFetchRequest<CDLanguageResponseEntity>(entityName: CoreDataEntityName.CDLanguageResponseEntity)
        
        do {
            self.result?(.success(try managedObjectContext.fetch(fetchRequest).map({ $0.languageResponse })))
            self.finish()
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
