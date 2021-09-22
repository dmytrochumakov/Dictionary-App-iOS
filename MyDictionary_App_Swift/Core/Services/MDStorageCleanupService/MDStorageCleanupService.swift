//
//  MDStorageCleanupService.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 22.09.2021.
//

import Foundation

protocol MDStorageCleanupServiceProtocol {
    func clearAllStorages(completionHandler: @escaping(([MDStorageServiceOperationResult]) -> Void))
}

final class MDStorageCleanupService: MDStorageCleanupServiceProtocol {
    
    fileprivate let jwtStorage: MDJWTStorageProtocol
    fileprivate let userStorage: MDUserStorageProtocol
    fileprivate let languageStorage: MDLanguageStorageProtocol
    fileprivate let courseStorage: MDCourseStorageProtocol
    fileprivate let wordStorage: MDWordStorageProtocol
    
    init(jwtStorage: MDJWTStorageProtocol,
         userStorage: MDUserStorageProtocol,
         languageStorage: MDLanguageStorageProtocol,
         courseStorage: MDCourseStorageProtocol,
         wordStorage: MDWordStorageProtocol) {
        
        self.jwtStorage = jwtStorage
        self.userStorage = userStorage
        self.languageStorage = languageStorage
        self.courseStorage = courseStorage
        self.wordStorage = wordStorage
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Clear All Storages
extension MDStorageCleanupService {
    
    func clearAllStorages(completionHandler: @escaping(([MDStorageServiceOperationResult]) -> Void)) {
        deleteAllData(completionHandler: completionHandler)
    }
    
}

// MARK: - Delete Data
fileprivate extension MDStorageCleanupService {
    
    func deleteAllData(completionHandler: @escaping(([MDStorageServiceOperationResult]) -> Void)) {
        
        // Initialize Sync Results
        var syncResults: [MDStorageServiceOperationResult] = []
        
        // Initialize Dispatch Group
        let dispatchGroup: DispatchGroup = .init()
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Delete All JWT
        deleteAllJWT { result in
            // Append Sync Result
            syncResults.append(result)
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Delete All Users
        deleteAllUsers { result in
            // Append Sync Result
            syncResults.append(result)
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Delete All Languages
        deleteAllLanguages { result in
            // Append Sync Result
            syncResults.append(result)
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Delete All Courses
        deleteAllCourses { result in
            // Append Sync Result
            syncResults.append(result)
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Delete All Words
        deleteAllWords { result in
            // Append Sync Result
            syncResults.append(result)
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Notify And Pass Final Result
        dispatchGroup.notify(queue: .main) {
            completionHandler(syncResults)
        }
        
    }
    
    func deleteAllJWT(completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) {
        
        let storageServiceType: MDStorageServiceType = .jwt
        var countResult: Int = .zero
        
        jwtStorage.deleteAllJWT(storageType: .all) { deleteJWTsResults in
            
            deleteJWTsResults.forEach { deleteJWTsResult in
                
                switch deleteJWTsResult.result {
                    
                case .success:
                    
                    countResult += 1
                    
                    if (countResult == deleteJWTsResults.count) {
                        completionHandler(.init(storageServiceType: storageServiceType, result: .success(())))
                    }
                    
                case .failure(let error):
                    completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                }
                
            }
            
        }
        
    }
    
    func deleteAllUsers(completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) {
        
        let storageServiceType: MDStorageServiceType = .user
        var countResult: Int = .zero
        
        userStorage.deleteAllUsers(storageType: .all) { deleteUsersResults in
            
            deleteUsersResults.forEach { deleteUsersResult in
                
                switch deleteUsersResult.result {
                    
                case .success:
                    
                    countResult += 1
                    
                    if (countResult == deleteUsersResults.count) {
                        completionHandler(.init(storageServiceType: storageServiceType, result: .success(())))
                    }
                    
                case .failure(let error):
                    completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                }
                
            }
            
        }
        
    }
    
    func deleteAllLanguages(completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) {
        
        let storageServiceType: MDStorageServiceType = .language
        var countResult: Int = .zero
        
        languageStorage.deleteAllLanguages(storageType: .all) { deleteLanguagesResults in
            
            deleteLanguagesResults.forEach { deleteLanguagesResult in
                
                switch deleteLanguagesResult.result {
                    
                case .success:
                    
                    countResult += 1
                    
                    if (countResult == deleteLanguagesResults.count) {
                        completionHandler(.init(storageServiceType: storageServiceType, result: .success(())))
                    }
                    
                case .failure(let error):
                    completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                }
                
            }
            
        }
        
    }
    
    func deleteAllCourses(completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) {
        
        let storageServiceType: MDStorageServiceType = .course
        var countResult: Int = .zero
        
        courseStorage.deleteAllCourses(storageType: .all) { deleteCoursesResults in
            
            deleteCoursesResults.forEach { deleteCoursesResult in
                
                switch deleteCoursesResult.result {
                    
                case .success:
                    
                    countResult += 1
                    
                    if (countResult == deleteCoursesResults.count) {
                        completionHandler(.init(storageServiceType: storageServiceType, result: .success(())))
                    }
                    
                case .failure(let error):
                    completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                }
                
            }
            
        }
        
    }
    
    func deleteAllWords(completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) {
        
        let storageServiceType: MDStorageServiceType = .word
        var countResult: Int = .zero
        
        wordStorage.deleteAllWords(storageType: .all) { deleteWordsResults in
            
            deleteWordsResults.forEach { deleteWordsResult in
                
                switch deleteWordsResult.result {
                    
                case .success:
                    
                    countResult += 1
                    
                    if (countResult == deleteWordsResults.count) {
                        completionHandler(.init(storageServiceType: storageServiceType, result: .success(())))
                    }
                    
                case .failure(let error):
                    completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                }
                
            }
            
        }
        
    }
    
}
