//
//  MDStorageCleanupService.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 22.09.2021.
//

import Foundation

protocol MDStorageCleanupServiceProtocol {
    func clearAllStorages(completionHandler: @escaping(([MDStorageServiceOperationResult]) -> Void)) -> BlockOperation
}

final class MDStorageCleanupService: MDStorageCleanupServiceProtocol {
    
    fileprivate static let allServicesCount: Int = MDStorageServiceType.allCases.count
    fileprivate let jwtStorage: MDJWTStorageProtocol
    fileprivate let userStorage: MDUserStorageProtocol
    fileprivate let languageStorage: MDLanguageStorageProtocol
    fileprivate let courseStorage: MDCourseStorageProtocol
    fileprivate let wordStorage: MDWordStorageProtocol
    fileprivate let operationQueue: OperationQueue
    
    init(jwtStorage: MDJWTStorageProtocol,
         userStorage: MDUserStorageProtocol,
         languageStorage: MDLanguageStorageProtocol,
         courseStorage: MDCourseStorageProtocol,
         wordStorage: MDWordStorageProtocol,
         operationQueue: OperationQueue) {
        
        self.jwtStorage = jwtStorage
        self.userStorage = userStorage
        self.languageStorage = languageStorage
        self.courseStorage = courseStorage
        self.wordStorage = wordStorage
        self.operationQueue = operationQueue
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Clear All Storages
extension MDStorageCleanupService {
    
    func clearAllStorages(completionHandler: @escaping(([MDStorageServiceOperationResult]) -> Void)) -> BlockOperation {
        return deleteAllData(completionHandler: completionHandler)
    }
    
}

// MARK: - Delete Data
fileprivate extension MDStorageCleanupService {
    
    func deleteAllData(completionHandler: @escaping(([MDStorageServiceOperationResult]) -> Void)) -> BlockOperation {
        
        let operation: BlockOperation = .init {
            
            // Initialize Sync Results
            var results: [MDStorageServiceOperationResult] = []
            
            // Delete All JWT
            let deleteAllJWTOperation = self.deleteAllJWT { result in
                // Append Sync Result
                results.append(result)
                // Notify And Pass Final Result
                if (results.count == Self.allServicesCount) {
                    completionHandler(results)
                }
                //
            }
            
            // Delete All Users
            let deleteAllUsersOperation = self.deleteAllUsers { result in
                // Append Sync Result
                results.append(result)
                // Notify And Pass Final Result
                if (results.count == Self.allServicesCount) {
                    completionHandler(results)
                }
                //
            }
            
            // Delete All Languages
            let deleteAllLanguagesOperation = self.deleteAllLanguages { result in
                // Append Sync Result
                results.append(result)
                // Notify And Pass Final Result
                if (results.count == Self.allServicesCount) {
                    completionHandler(results)
                }
                //
            }
            
            // Delete All Courses
            let deleteAllCoursesOperation = self.deleteAllCourses { result in
                // Append Sync Result
                results.append(result)
                // Notify And Pass Final Result
                if (results.count == Self.allServicesCount) {
                    completionHandler(results)
                }
                //
            }
            
            // Delete All Words
            let deleteAllWordsOperation = self.deleteAllWords { result in
                // Append Sync Result
                results.append(result)
                // Notify And Pass Final Result
                if (results.count == Self.allServicesCount) {
                    completionHandler(results)
                }
                //
            }
            
            // Add Operations
            self.operationQueue.addOperations([deleteAllJWTOperation,
                                               deleteAllUsersOperation,
                                               deleteAllLanguagesOperation,
                                               deleteAllCoursesOperation,
                                               deleteAllWordsOperation],
                                              waitUntilFinished: true)
            //
            
        }
        
        return operation
        
    }
    
    func deleteAllJWT(completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) -> BlockOperation {
        
        let operation: BlockOperation = .init {
            
            let storageServiceType: MDStorageServiceType = .jwt
            var countResult: Int = .zero
            
            self.jwtStorage.deleteAllJWT(storageType: .all) { deleteJWTsResults in
                
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
        
        return operation
        
    }
    
    func deleteAllUsers(completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) -> BlockOperation {
        
        let operation: BlockOperation = .init {
            
            let storageServiceType: MDStorageServiceType = .user
            var countResult: Int = .zero
            
            self.userStorage.deleteAllUsers(storageType: .all) { deleteUsersResults in
                
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
        
        return operation
        
    }
    
    func deleteAllLanguages(completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) -> BlockOperation {
        
        let operation: BlockOperation = .init {
            
            let storageServiceType: MDStorageServiceType = .language
            var countResult: Int = .zero
            
            self.languageStorage.deleteAllLanguages(storageType: .all) { deleteLanguagesResults in
                
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
        
        return operation
        
    }
    
    func deleteAllCourses(completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) -> BlockOperation {
        
        let operation: BlockOperation = .init {
            
            let storageServiceType: MDStorageServiceType = .course
            var countResult: Int = .zero
            
            self.courseStorage.deleteAllCourses(storageType: .all) { deleteCoursesResults in
                
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
        
        return operation
        
    }
    
    func deleteAllWords(completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) -> BlockOperation {
        
        let operation: BlockOperation = .init {
            
            let storageServiceType: MDStorageServiceType = .word
            var countResult: Int = .zero
            
            self.wordStorage.deleteAllWords(storageType: .all) { deleteWordsResults in
                
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
        
        return operation
        
    }
    
}
