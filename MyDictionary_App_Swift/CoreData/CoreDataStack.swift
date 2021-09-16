//
//  CoreDataStack.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import CoreData

open class CoreDataStack {
    
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
                                              managedObjectModel: CoreDataStack.model)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
}

// MARK: - Save
extension CoreDataStack {
    
    public func save() throws {
        self.privateContext.perform {
            debugPrint(#function, Self.self)
        }
        self.mainContext.perform {
            debugPrint(#function, Self.self)
        }
    }
    
}
