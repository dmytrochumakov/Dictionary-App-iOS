//
//  TestCoreDataStack.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import XCTest
import CoreData
@testable import MyDictionary_App_Swift

final class TestCoreDataStack: CoreDataStack {
    
    override init() {
        super.init()
                
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSSQLiteStoreType
        
        let container = NSPersistentContainer(
            name: Constants.StaticText.appName,
            managedObjectModel: CoreDataStack.model)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        storeContainer = container
        
    }
    
}
