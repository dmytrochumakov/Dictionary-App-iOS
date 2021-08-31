//
//  MDCreateCourseCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 24.08.2021.
//

import CoreData

final class MDCreateCourseCoreDataStorageOperation: MDOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStorage: MDCourseCoreDataStorage
    fileprivate let courseEntity: CourseResponse
    fileprivate let result: MDOperationResultWithCompletion<CourseResponse>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStorage: MDCourseCoreDataStorage,
         courseEntity: CourseResponse,
         result: MDOperationResultWithCompletion<CourseResponse>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStorage = coreDataStorage
        self.courseEntity = courseEntity
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        let newCourseEntity = CDCourseResponseEntity.init(courseResponse: self.courseEntity,
                                                          insertIntoManagedObjectContext: self.managedObjectContext)
        
        self.coreDataStorage.save(courseID: newCourseEntity.courseId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let createdCourse):
                    self?.result?(.success(createdCourse))
                    self?.finish()
                case .failure(let error):
                    self?.result?(.failure(error))
                    self?.finish()
                }
            }
        }
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
