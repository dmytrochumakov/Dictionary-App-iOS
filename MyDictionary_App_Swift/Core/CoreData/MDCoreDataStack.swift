//
//  MDCoreDataStack.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import CoreData

open class MDCoreDataStack: NSObject {
    
    fileprivate let coreDataManager: MDCoreDataManager
    
    public var privateContext: NSManagedObjectContext {
        return coreDataManager.backgroundContext
    }
    
    init(coreDataManager: MDCoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Save
extension MDCoreDataStack {
    
    func save(managedObjectContext: NSManagedObjectContext,
              completionHandler: @escaping MDOperationResultWithCompletion<Void>) {
        
        managedObjectContext.perform {
            
            do {
                
                //
                try managedObjectContext.save()
                //
                
                //
                completionHandler(.success(()))
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
