//
//  MDCoreDataStack.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import CoreData

open class MDCoreDataStack: NSObject {
    
    fileprivate var mainContext: NSManagedObjectContext
    public var privateContext: NSManagedObjectContext
    
    public override init() {
        
        //
        let mainContext: NSManagedObjectContext = .init(concurrencyType: .mainQueueConcurrencyType)
        self.mainContext = mainContext
        //
        
        //
        let privateContext: NSManagedObjectContext = .init(concurrencyType: .privateQueueConcurrencyType)
        self.privateContext = privateContext
        
        //
        
        super.init()
        
        //
        self.mainContext.persistentStoreCoordinator = self.coordinator
        //
        
        //
        self.privateContext.persistentStoreCoordinator = self.coordinator
        //
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
    fileprivate var coordinator: NSPersistentStoreCoordinator {
        return storeContainer.persistentStoreCoordinator
    }
    
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
    
    public static let model: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: MDConstants.StaticText.appName,
                                       withExtension: MDConstants.StaticText.momdExtension)!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
}

// MARK: - Save
extension MDCoreDataStack {
    
    public func save(managedObjectContext: NSManagedObjectContext,
                     completionHandler: @escaping CDResultSaved) {
        
        managedObjectContext.performAndWait {
            
            do {
                
                //
                try managedObjectContext.save()
                //
                
                //
                completionHandler(.success)
                //
                
                //
                return
                //
                
            } catch {
                
                //
                completionHandler(.failure(error))
                //
                
                //
                return
                //
                
            }
            
        }
        
    }
    
}
