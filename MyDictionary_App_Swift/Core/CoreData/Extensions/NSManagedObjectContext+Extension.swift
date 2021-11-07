//
//  NSManagedObjectContext+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 07.11.2021.
//

import CoreData

extension NSManagedObjectContext {
    
    convenience init(model: NSManagedObjectModel, storeURL: URL) {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        try! persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        
        self.init(concurrencyType: .mainQueueConcurrencyType)
        
        self.persistentStoreCoordinator = persistentStoreCoordinator
    }
    
    func destroyStore() {
        persistentStoreCoordinator?.persistentStores.forEach {
            try? persistentStoreCoordinator?.remove($0)
            try? persistentStoreCoordinator?.destroyPersistentStore(at: $0.url!, ofType: $0.type, options: nil)
        }
    }
    
}
