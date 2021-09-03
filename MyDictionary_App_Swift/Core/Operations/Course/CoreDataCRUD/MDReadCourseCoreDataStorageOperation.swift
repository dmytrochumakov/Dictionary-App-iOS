//
//  MDReadCourseCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 24.08.2021.
//

import CoreData

final class MDReadCourseCoreDataStorageOperation: MDOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStorage: MDCourseCoreDataStorage
    fileprivate let courseId: Int64
    fileprivate let result: MDOperationResultWithCompletion<CourseResponse>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStorage: MDCourseCoreDataStorage,
         courseId: Int64,
         result: MDOperationResultWithCompletion<CourseResponse>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStorage = coreDataStorage
        self.courseId = courseId
        self.result = result
        
        super.init()
        
    }
    
    override func main() {
        
        let fetchRequest = NSFetchRequest<CDCourseResponseEntity>(entityName: CoreDataEntityName.CDCourseResponseEntity)
        fetchRequest.predicate = NSPredicate(format: "\(CDCourseResponseEntityAttributeName.courseId) == %i", self.courseId)
        
        do {            
            if let courseEntity = try managedObjectContext.fetch(fetchRequest).map({ $0.courseResponse }).first {
                self.result?(.success(courseEntity))
                self.finish()
            } else {
                self.result?(.failure(MDEntityOperationError.cantFindEntity))
                self.finish()
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
