//
//  MDReadAllCoursesCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 24.08.2021.
//

import CoreData

final class MDReadAllCoursesCoreDataStorageOperation: MDAsyncOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStorage: MDCourseCoreDataStorage
    fileprivate let result: MDOperationsResultWithCompletion<CourseResponse>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStorage: MDCourseCoreDataStorage,
         result: MDOperationsResultWithCompletion<CourseResponse>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStorage = coreDataStorage
        self.result = result
        
        super.init()
        
    }
    
    override func main() {
        
        let fetchRequest = NSFetchRequest<CDCourseResponseEntity>(entityName: CoreDataEntityName.CDCourseResponseEntity)
        
        do {
            self.result?(.success(try managedObjectContext.fetch(fetchRequest).map({ $0.courseResponse })))
            self.finish()
        } catch let error {
            self.result?(.failure(error))
            self.finish()
        }
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
