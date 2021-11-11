//
//  MDCourseManager.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 10.11.2021.
//

import Foundation

protocol MDCourseManagerProtocol: MDCreateCourseProtocol,
                                  MDDeleteCourseByCourseUUIDProtocol {
    
}

final class MDCourseManager: MDCourseManagerProtocol {
    
    fileprivate let courseCoreDataStorage: MDCourseCoreDataStorageProtocol
    fileprivate let deleteAllWordsCourseUUIDService: MDDeleteAllWordsByCourseUUIDProtocol
    
    init(courseCoreDataStorage: MDCourseCoreDataStorageProtocol,
         deleteAllWordsCourseUUIDService: MDDeleteAllWordsByCourseUUIDProtocol) {
        
        self.courseCoreDataStorage = courseCoreDataStorage
        self.deleteAllWordsCourseUUIDService = deleteAllWordsCourseUUIDService
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Create
extension MDCourseManager {
    
    func createCourse(uuid: UUID,
                      languageId: Int16,
                      createdAt: Date,
                      _ completionHandler: @escaping(MDOperationResultWithCompletion<CDCourseEntity>)) {
        
        courseCoreDataStorage.exists(byLanguageId: languageId) { [unowned self] existsResult in
            
            switch existsResult {
                
            case .success(let exists):
                
                if (exists) {
                    
                    //
                    completionHandler(.failure(MDCourseOperationError.courseExists))
                    //
                    
                    //
                    return
                    //
                    
                } else {
                    
                    //
                    courseCoreDataStorage.createCourse(uuid: uuid,
                                                       languageId: languageId,
                                                       createdAt: createdAt) { createResult in
                        
                        //
                        completionHandler(createResult)
                        //
                        
                        //
                        return
                        //
                        
                    }
                    //
                    
                }
                
                //
                break
                //
                
            case .failure(let error):
                
                //
                completionHandler(.failure(error))
                //
                
                //
                break
                //
                
            }
            
        }
        
    }
    
}

// MARK: - Delete
extension MDCourseManager {
    
    func deleteCourse(byCourseUUID uuid: UUID,
                      _ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        courseCoreDataStorage.deleteCourse(byCourseUUID: uuid) { [unowned self] deleteCourseResult in
            
            switch deleteCourseResult {
                
            case .success:
                
                deleteAllWordsCourseUUIDService.deleteAllWords(byCourseUUID: uuid) { deleteWordsResult in
                    
                    //
                    completionHandler(deleteWordsResult)
                    //
                    
                    //
                    return
                    //
                    
                }
                
                //
                break
                //
                
            case .failure(let error):
                
                //
                completionHandler(.failure(error))
                //
                
                //
                break
                //
                
            }
            
        }
        
    }
    
}
