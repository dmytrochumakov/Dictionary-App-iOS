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
    
    public func save(context: NSManagedObjectContext, completionHandler: @escaping CDResultSaved) {
        savePerformAndWaitContext(context, completionHandler: completionHandler)
        savePerformMainContext()
    }
    
}

fileprivate extension MDCoreDataStack {       
    
    func savePerformMainContext() {
        savePerformContext(mainContext) { result in            
            switch result {
            case .success:
                debugPrint(#function, Self.self, "Success")
                break
            case .failure(let error):
                debugPrint(#function, Self.self, "Failure", "error: ", error.localizedDescription)
                break
            }
        }
    }
    
    func savePerformAndWaitContext(_ context: NSManagedObjectContext, completionHandler: @escaping CDResultSaved) {
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
    
    func savePerformContext(_ context: NSManagedObjectContext, completionHandler: @escaping CDResultSaved) {
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
