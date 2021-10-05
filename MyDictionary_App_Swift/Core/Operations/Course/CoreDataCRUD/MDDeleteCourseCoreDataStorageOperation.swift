//
//  MDDeleteCourseCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 24.08.2021.
//

import CoreData

final class MDDeleteCourseCoreDataStorageOperation: MDAsyncOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStack: MDCoreDataStack
    fileprivate let coreDataStorage: MDCourseCoreDataStorage
    fileprivate let courseId: Int64
    fileprivate let result: MDOperationResultWithCompletion<Void>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStack: MDCoreDataStack,
         coreDataStorage: MDCourseCoreDataStorage,
         courseId: Int64,
         result: MDOperationResultWithCompletion<Void>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
        self.coreDataStorage = coreDataStorage
        self.courseId = courseId
        self.result = result
        
        super.init()
        
    }
    
    override func main() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityName.CDCourseResponseEntity)
        fetchRequest.predicate = NSPredicate(format: "\(CDCourseResponseEntityAttributeName.courseId) == %i", self.courseId)
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            
            try managedObjectContext.execute(batchDeleteRequest)
            
            coreDataStack.save(managedObjectContext: managedObjectContext) { [weak self] result in
                
                switch result {
                
                case .success:
                    
                    self?.result?(.success(()))
                    self?.finish()
                    break
                    
                case .failure(let error):
                    
                    self?.result?(.failure(error))
                    self?.finish()
                    break
                    
                }
                
            }
            
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
