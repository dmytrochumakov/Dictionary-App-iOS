//
//  MDCoreDataManager.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 07.11.2021.
//

import CoreData

final class MDCoreDataManager {
    
    fileprivate let storeType: String
    fileprivate let migrator: MDCoreDataMigratorProtocol
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: MDConstants.StaticText.appName)
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.shouldInferMappingModelAutomatically = false
        description?.shouldMigrateStoreAutomatically = false
        description?.type = storeType
        return persistentContainer
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        let context = self.persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }()
    
    fileprivate lazy var mainContext: NSManagedObjectContext = {
        let context = self.persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    
    init(storeType: String,
         migrator: MDCoreDataMigratorProtocol) {
        
        self.storeType = storeType
        self.migrator = migrator
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Public Methods
extension MDCoreDataManager {
    
    func setup(completion: @escaping () -> Void) {
        loadPersistentStore {
            completion()
        }
    }
    
}

// MARK: - Private Methods
fileprivate extension MDCoreDataManager {
    
    func loadPersistentStore(completion: @escaping () -> Void) {
        migrateStoreIfNeeded { [weak self] in
            self?.persistentContainer.loadPersistentStores { description, error in
                guard error == nil else {
                    fatalError("was unable to load store \(error!)")
                }
                
                completion()
            }
        }
    }
    
    func migrateStoreIfNeeded(completion: @escaping () -> Void) {
        
        guard let storeURL = persistentContainer.persistentStoreDescriptions.first?.url else {
            fatalError("persistentContainer was not set up properly")
        }
        
        if migrator.requiresMigration(at: storeURL,
                                      toVersion: MDCoreDataMigrationVersion.current) {
            
            DispatchQueue.global(qos: .userInitiated).async {
                
                //
                self.migrator.migrateStore(at: storeURL,
                                           toVersion: MDCoreDataMigrationVersion.current)
                //
                
                DispatchQueue.main.async {
                    completion()
                }
                
            }
            
        } else {
            completion()
        }
        
    }
    
}
