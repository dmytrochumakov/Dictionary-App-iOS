//
//  MDCoreDataStack.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import CoreData

open class MDCoreDataStack {
    
    public static let model: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: MDConstants.StaticText.appName,
                                       withExtension: MDConstants.StaticText.momdExtension)!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    public init() {
    }
    
    fileprivate lazy var mainContext: NSManagedObjectContext = {
        return storeContainer.viewContext
    }()
    
    public lazy var privateContext: NSManagedObjectContext = {
        let moc = NSManagedObjectContext.init(concurrencyType: .privateQueueConcurrencyType)
        moc.parent = mainContext
        return moc
    }()
    
    public lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: MDConstants.StaticText.appName,
                                              managedObjectModel: MDCoreDataStack.model)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
}

// MARK: - Save
extension MDCoreDataStack {
    
    public func save(managedObjectContext: NSManagedObjectContext, completionHandler: @escaping CDResultSaved) {
        
        managedObjectContext.performAndWait {
            
            mainContext.performAndWait {
                
                do {
                    if (managedObjectContext.hasChanges)  {
                        try managedObjectContext.save()
                    }
                    if (self.mainContext.hasChanges) {
                        try self.mainContext.save()
                    }
                    completionHandler(.success)
                } catch {
                    completionHandler(.failure(error))
                }
                
            }
            
        }
        
    }
    
}
