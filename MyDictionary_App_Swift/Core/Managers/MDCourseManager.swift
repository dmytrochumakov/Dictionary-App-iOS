//
//  MDCourseManager.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 20.09.2021.
//

import Foundation

protocol MDCourseManagerProtocol {
    
    func addCourse(byLanguage language: LanguageResponse,
                   _ completionHandler: @escaping(MDOperationResultWithCompletion<CourseResponse>))
    
    func deleteCourseFromApiAndAllStorage(byCourseId courseId: Int64,
                                          _ completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
    
}

final class MDCourseManager: MDCourseManagerProtocol {
    
    fileprivate let jwtManager: MDJWTManagerProtocol
    fileprivate let apiCourse: MDAPICourseProtocol
    fileprivate let courseStorage: MDCourseStorageProtocol
    fileprivate let wordStorage: MDWordStorageProtocol
    
    init(jwtManager: MDJWTManagerProtocol,
         apiCourse: MDAPICourseProtocol,
         courseStorage: MDCourseStorageProtocol,
         wordStorage: MDWordStorageProtocol) {
        
        self.jwtManager = jwtManager
        self.apiCourse = apiCourse
        self.courseStorage = courseStorage
        self.wordStorage = wordStorage
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDCourseManager {
    
    func addCourse(byLanguage language: LanguageResponse,
                   _ completionHandler: @escaping(MDOperationResultWithCompletion<CourseResponse>)) {
        
        var resultCount: Int = .zero
        
        jwtManager.fetchUserAndJWT { [unowned self] fetchUserAndJWTResult in
            
            switch fetchUserAndJWTResult {
                
            case .success(let userAndJWT):
                
                apiCourse.createCourse(accessToken: userAndJWT.jwt.accessToken,
                                       createCourseRequest: .init(userId: userAndJWT.user.userId,
                                                                  languageId: language.languageId,
                                                                  languageName: language.languageName)) { [unowned self] createApiCourseResult in
                    
                    switch createApiCourseResult {
                        
                    case .success(let courseResponse):
                        
                        courseStorage.createCourse(storageType: .all,
                                                   courseEntity: courseResponse) { createStorageCourseResults in
                            
                            createStorageCourseResults.forEach { createStorageCourseResult in
                                
                                switch createStorageCourseResult.result {
                                    
                                case .success:
                                    
                                    //
                                    resultCount += 1
                                    //
                                    
                                    if (resultCount == createStorageCourseResults.count) {
                                        //
                                        completionHandler(.success(courseResponse))
                                        //
                                        break
                                        //
                                    }
                                    
                                case .failure(let error):
                                    
                                    //
                                    completionHandler(.failure(error))
                                    //
                                    break
                                    //
                                }
                                
                            }
                            
                        }
                        break
                        
                    case .failure(let error):
                        
                        //
                        completionHandler(.failure(error))
                        //
                        break
                        //
                        
                    }
                    
                }
                
                break
                
            case .failure(let error):
                
                //
                completionHandler(.failure(error))
                //
                break
                //
                
            }
            
        }
        
    }
    
}

extension MDCourseManager {
    
    func deleteCourseFromApiAndAllStorage(byCourseId courseId: Int64,
                                          _ completionHandler: @escaping(MDOperationResultWithCompletion<Void>)) {
        
        var resultCount: Int = .zero
        
        jwtManager.fetchUserAndJWT { [unowned self] fetchUserAndJWTResult in
            
            switch fetchUserAndJWTResult {
                
            case .success(let userAndJWT):
                
                apiCourse.deleteCourse(accessToken: userAndJWT.jwt.accessToken,
                                       userId: userAndJWT.user.userId,
                                       courseId: courseId) { [unowned self] (apiDeleteCourseResult) in
                    
                    switch apiDeleteCourseResult {
                        
                    case .success:
                        //
                        courseStorage.deleteCourse(storageType: .all,
                                                   fromCourseId: courseId) { [unowned self] (storageDeleteCourseResults) in
                            
                            storageDeleteCourseResults.forEach { storageDeleteCourseResult in
                                
                                switch storageDeleteCourseResult.result {
                                    
                                case .success:
                                    
                                    wordStorage.deleteAllWords(byCourseId: courseId,
                                                               storageType: storageDeleteCourseResult.storageType) { (deleteAllWordsResults) in
                                        
                                        deleteAllWordsResults.forEach { deleteAllWordsResult in
                                            
                                            switch deleteAllWordsResult.result {
                                                
                                            case .success:
                                                
                                                resultCount += 1
                                                
                                                if (resultCount == deleteAllWordsResults.count) {
                                                    completionHandler(.success(()))
                                                }
                                                
                                            case .failure(let error):
                                                
                                                //
                                                completionHandler(.failure(error))
                                                //
                                                break
                                                //
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                    
                                case .failure(let error):
                                    //
                                    completionHandler(.failure(error))
                                    //
                                    break
                                    //
                                }
                                
                            }
                            
                        }
                        
                        //
                    case .failure(let error):
                        //
                        completionHandler(.failure(error))
                        //
                        break
                        //
                    }
                    
                }
                
            case .failure(let error):
                //
                completionHandler(.failure(error))
                //
                break
                //
            }
            
        }
        
    }
    
}
