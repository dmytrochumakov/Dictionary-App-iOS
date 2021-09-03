//
//  CoreDataStack.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import CoreData

open class CoreDataStack {
    
    public static let model: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: Constants.StaticText.appName,
                                       withExtension: Constants.StaticText.momdExtension)!
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
        let container = NSPersistentContainer(name: Constants.StaticText.appName,
                                              managedObjectModel: CoreDataStack.model)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
}

// MARK: - Save Context
extension CoreDataStack {
    
    public func savePerformAndWait(completionHandler: @escaping CDResultSaved) {
        savePerformAndWaitContext(privateContext, completionHandler: completionHandler)
        savePerformAndWaitContext(mainContext, completionHandler: completionHandler)
    }
    
    public func savePerform(completionHandler: @escaping CDResultSaved) {
        savePerformContext(privateContext, completionHandler: completionHandler)
        savePerformContext(mainContext, completionHandler: completionHandler)
    }
    
    private func savePerformAndWaitContext(_ context: NSManagedObjectContext, completionHandler: @escaping CDResultSaved) {
        context.performAndWait {
            do {
                try context.save()
                completionHandler(.success)
            } catch {
                let nsError = error as NSError
                debugPrint(#function, "Unresolved error \(nsError), \(nsError.userInfo)")
                completionHandler(.failure(error))
            }
        }
    }
    
    private func savePerformContext(_ context: NSManagedObjectContext, completionHandler: @escaping CDResultSaved) {
        context.perform {
            do {
                try context.save()
                completionHandler(.success)
            } catch {
                let nsError = error as NSError
                debugPrint(#function, "Unresolved error \(nsError), \(nsError.userInfo)")
                completionHandler(.failure(error))
            }
        }
    }
    
}

// MARK: - Static Save Context
extension CoreDataStack {
    
    static func savePerform(coreDataStack: CoreDataStack,
                            completionHandler: @escaping CDResultSaved) {
        
        coreDataStack.savePerform(completionHandler: completionHandler)
        
    }
    
    static func savePerformAndWait(coreDataStack: CoreDataStack,
                                   completionHandler: @escaping CDResultSaved) {
        
        coreDataStack.savePerformAndWait(completionHandler: completionHandler)
        
    }
    
}
