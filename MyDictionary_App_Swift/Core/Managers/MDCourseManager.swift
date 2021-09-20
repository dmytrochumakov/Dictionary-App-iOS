//
//  MDCourseManager.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 20.09.2021.
//

import Foundation

protocol MDCourseManagerProtocol {
    func deleteCourseFromApiAndAllStorage(byCourseId courseId: Int64,
                                          _ completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
}

final class MDCourseManager: MDCourseManagerProtocol {
    
    fileprivate let userMemoryStorage: MDUserMemoryStorageProtocol
    fileprivate let jwtManager: MDJWTManagerProtocol
    fileprivate let apiCourse: MDAPICourseProtocol
    fileprivate let courseStorage: MDCourseStorageProtocol
    
    init(userMemoryStorage: MDUserMemoryStorageProtocol,
         jwtManager: MDJWTManagerProtocol,
         apiCourse: MDAPICourseProtocol,
         courseStorage: MDCourseStorageProtocol) {
        
        self.userMemoryStorage = userMemoryStorage
        self.jwtManager = jwtManager
        self.apiCourse = apiCourse
        self.courseStorage = courseStorage
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDCourseManager {
    
    func deleteCourseFromApiAndAllStorage(byCourseId courseId: Int64,
                                          _ completionHandler: @escaping(MDOperationResultWithCompletion<Void>)) {
        
        var resultCount: Int = .zero
        
        userMemoryStorage.readFirstUser { [unowned self] readUserResult in
            
            switch readUserResult {
            
            case .success(let userResponse):
                
                jwtManager.fetchJWT(nickname: userResponse.nickname,
                                    password: userResponse.password!,
                                    userId: userResponse.userId) { [unowned self] (fetchResult) in
                    
                    switch fetchResult {
                    
                    case .success(let jwtResponse):
                        
                        apiCourse.deleteCourse(accessToken: jwtResponse.accessToken,
                                               userId: userResponse.userId,
                                               courseId: courseId) { [unowned self] (apiDeleteCourseResult) in
                            
                            switch apiDeleteCourseResult {
                            
                            case .success:
                                //
                                courseStorage.deleteCourse(storageType: .all,
                                                           fromCourseId: courseId) { (storageDeleteCourseResults) in
                                    
                                    storageDeleteCourseResults.forEach { storageDeleteCourseResult in
                                        
                                        switch storageDeleteCourseResult.result {
                                        
                                        case .success:
                                            
                                            resultCount += 1
                                            
                                            if (resultCount == storageDeleteCourseResults.count) {
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
