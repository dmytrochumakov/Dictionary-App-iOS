//
//  MDSync.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 31.08.2021.
//

import Foundation

protocol MDSyncProtocol {
    
    func startFullSyncWithDeleteAllData(withSyncItem item: MDSync.Item,
                                        progressCompletionHandler: @escaping((Float) -> Void),
                                        completionHandler: @escaping(([MDStorageServiceOperationResult]) -> Void))
    
    func startWithJWTAndUserAndLanguageSync(withSyncItem item: MDSync.Item,
                                            progressCompletionHandler: @escaping((Float) -> Void),
                                            completionHandler: @escaping(([MDStorageServiceOperationResult]) -> Void))
    
}

final class MDSync: MDSyncProtocol {
    
    public struct Item {
        let accessToken: String
        let password: String
        let userId: Int64
        let nickname: String
    }
    
    fileprivate static let fullSyncCount: Int = MDStorageServiceType.allCases.count
    fileprivate static let jwtAndUserAndLanguageSyncCount: Int = 3
    
    fileprivate let apiJWT: MDAPIJWTProtocol
    fileprivate let jwtStorage: MDJWTStorageProtocol
    fileprivate let apiUser: MDAPIUserProtocol
    fileprivate let userStorage: MDUserStorageProtocol
    fileprivate let apiLanguage: MDAPILanguageProtocol
    fileprivate let languageStorage: MDLanguageStorageProtocol
    fileprivate let apiCourse: MDAPICourseProtocol
    fileprivate let courseStorage: MDCourseStorageProtocol
    fileprivate let apiWord: MDAPIWordProtocol
    fileprivate let wordStorage: MDWordStorageProtocol
    fileprivate let storageCleanupService: MDStorageCleanupServiceProtocol
    
    init(apiJWT: MDAPIJWTProtocol,
         jwtStorage: MDJWTStorageProtocol,
         apiUser: MDAPIUserProtocol,
         userStorage: MDUserStorageProtocol,
         apiLanguage: MDAPILanguageProtocol,
         languageStorage: MDLanguageStorageProtocol,
         apiCourse: MDAPICourseProtocol,
         courseStorage: MDCourseStorageProtocol,
         apiWord: MDAPIWordProtocol,
         wordStorage: MDWordStorageProtocol,
         storageCleanupService: MDStorageCleanupServiceProtocol) {
        
        self.apiJWT = apiJWT
        self.jwtStorage = jwtStorage
        self.apiUser = apiUser
        self.userStorage = userStorage
        self.apiLanguage = apiLanguage
        self.languageStorage = languageStorage
        self.apiCourse = apiCourse
        self.courseStorage = courseStorage
        self.apiWord = apiWord
        self.wordStorage = wordStorage
        self.storageCleanupService = storageCleanupService        
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDSync {
    
    func startFullSyncWithDeleteAllData(withSyncItem item: MDSync.Item,
                                        progressCompletionHandler: @escaping((Float) -> Void),
                                        completionHandler: @escaping(([MDStorageServiceOperationResult]) -> Void))  {
        
        self.storageCleanupService.clearAllStorages { [unowned self] clearAllStoragesResults in
            
            startFullSync(withSyncItem: item) { progress in
                progressCompletionHandler(progress)
            } completionHandler: { syncResults in
                completionHandler(clearAllStoragesResults + syncResults)
            }
            
        }
        
    }
    
    func startWithJWTAndUserAndLanguageSync(withSyncItem item: Item,
                                            progressCompletionHandler: @escaping((Float) -> Void),
                                            completionHandler: @escaping (([MDStorageServiceOperationResult]) -> Void)) {
        
        jwtAndUserAndLanguageSync(withSyncItem: item,
                                  progressCompletionHandler: { progress in
            progressCompletionHandler(progress)
        }, completionHandler: { results in
            completionHandler(results)
        })
        
    }
    
}

fileprivate extension MDSync {
    
    func startFullSync(withSyncItem item: MDSync.Item,
                       progressCompletionHandler: @escaping((Float) -> Void),
                       completionHandler: @escaping(([MDStorageServiceOperationResult]) -> Void)) {
        
        // Initialize Sync Results
        var syncResults: [MDStorageServiceOperationResult] = []
        
        // Get API And Save JWT
        self.apiGetAndSaveJWT(withSyncItem: item) { [unowned self] result in
            
            // Append Sync Result
            syncResults.append(result)
            
            // Compute And Pass Progress
            progressCompletionHandler(computeProgressForFullSync(finishedOperationsCount: syncResults.count))
            
            
            // Get API And Save User
            apiGetAndSaveUser(withSyncItem: item) { [unowned self] result in
                
                // Append Sync Result
                syncResults.append(result)
                
                // Compute And Pass Progress
                progressCompletionHandler(computeProgressForFullSync(finishedOperationsCount: syncResults.count))
                
                
                // Get API And Save Languages
                apiGetAndSaveLanguages(withSyncItem: item) { [unowned self] result in
                    
                    // Append Sync Result
                    syncResults.append(result)
                    
                    // Compute And Pass Progress
                    progressCompletionHandler(computeProgressForFullSync(finishedOperationsCount: syncResults.count))
                    
                    
                    // Get API And Save Courses
                    apiGetAndSaveCourses(withSyncItem: item) { [unowned self] result in
                        
                        // Append Sync Result
                        syncResults.append(result)
                        
                        // Compute And Pass Progress
                        progressCompletionHandler(computeProgressForFullSync(finishedOperationsCount: syncResults.count))
                        
                        // Get API And Save Words
                        apiGetAndSaveWords(withSyncItem: item) { [unowned self] result in
                            
                            // Append Sync Result
                            syncResults.append(result)
                            
                            // Compute And Pass Progress
                            progressCompletionHandler(computeProgressForFullSync(finishedOperationsCount: syncResults.count))
                            
                            // Pass Final Result
                            completionHandler(syncResults)
                            //
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func jwtAndUserAndLanguageSync(withSyncItem item: Item,
                                   progressCompletionHandler: @escaping((Float) -> Void),
                                   completionHandler: @escaping (([MDStorageServiceOperationResult]) -> Void)) {
        
        // Initialize Sync Results
        var syncResults: [MDStorageServiceOperationResult] = []
        
        // Get API And Save JWT
        self.apiGetAndSaveJWT(withSyncItem: item) { [unowned self] result in
            
            // Append Sync Result
            syncResults.append(result)
            
            // Compute And Pass Progress
            progressCompletionHandler(computeProgressForJWTAndUserAndLanguageSync(finishedOperationsCount: syncResults.count))
            
            
            // Get API And Save User
            self.apiGetAndSaveUser(withSyncItem: item) { [unowned self] result in
                
                // Append Sync Result
                syncResults.append(result)
                
                // Compute And Pass Progress
                progressCompletionHandler(computeProgressForJWTAndUserAndLanguageSync(finishedOperationsCount: syncResults.count))
                
                
                // Get API And Save Languages
                self.apiGetAndSaveLanguages(withSyncItem: item) { [unowned self] result in
                    
                    // Append Sync Result
                    syncResults.append(result)
                    
                    // Compute And Pass Progress
                    progressCompletionHandler(computeProgressForJWTAndUserAndLanguageSync(finishedOperationsCount: syncResults.count))
                    
                    // Pass Final Result
                    completionHandler(syncResults)
                    //
                    
                }
            }
            
        }
        
    }
    
    func computeProgressForFullSync(finishedOperationsCount: Int) -> Float {
        return Float(finishedOperationsCount) / Float(Self.fullSyncCount)
    }
    
    func computeProgressForJWTAndUserAndLanguageSync(finishedOperationsCount: Int) -> Float {
        return Float(finishedOperationsCount) / Float(Self.jwtAndUserAndLanguageSyncCount)
    }
    
}

// MARK: - API
fileprivate extension MDSync {
    
    // JWT
    func apiGetAndSaveJWT(withSyncItem item: MDSync.Item, completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) {
        
        debugPrint(#function, Self.self, "Start")
        
        //
        let storageServiceType: MDStorageServiceType = .jwt
        var countResult: Int = .zero
        //
        self.apiJWT.accessToken(jwtApiRequest: .init(nickname: item.nickname,
                                                     password: item.password,
                                                     userId: item.userId)) { [unowned self] jwtResult in
            //
            switch jwtResult {
                //
            case .success(let jwt):
                
                jwtStorage.createJWT(storageType: .all,
                                     jwtResponse: jwt) { createJWTResults in
                    //
                    createJWTResults.forEach { createJWTResult in
                        //
                        switch createJWTResult.result {
                            //
                        case .success:
                            //
                            countResult += 1
                            //
                            if (countResult == createJWTResults.count) {
                                debugPrint(#function, Self.self, "Success")
                                completionHandler(.init(storageServiceType: storageServiceType, result: .success(())))
                                break
                            }
                            //
                        case .failure(let error):
                            debugPrint(#function, Self.self, "Failure: ", "with error", error)
                            completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                            break
                        }
                        
                    }
                    
                }
                
            case .failure(let error):
                debugPrint(#function, Self.self, "Failure: ", "with error", error)
                completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                break
                
            }
            
        }
        
    }
    
    // User
    func apiGetAndSaveUser(withSyncItem item: MDSync.Item, completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) {
        
        debugPrint(#function, Self.self, "Start")
        
        //
        let storageServiceType: MDStorageServiceType = .user
        var countResult: Int = .zero
        //
        self.apiUser.getUser(accessToken: item.accessToken,
                             byUserId: item.userId) { [unowned self] userResult in
            //
            switch userResult {
                //
            case .success(let user):
                //
                userStorage.createUser(user,
                                       password: item.password,
                                       storageType: .all) { createUserResults in
                    //
                    createUserResults.forEach { createUserResult in
                        //
                        switch createUserResult.result {
                            //
                        case .success:
                            //
                            countResult += 1
                            //
                            if (countResult == createUserResults.count) {
                                debugPrint(#function, Self.self, "Success")
                                completionHandler(.init(storageServiceType: storageServiceType, result: .success(())))
                                break
                            }
                            
                        case .failure(let error):
                            debugPrint(#function, Self.self, "Failure: ", "with error", error)
                            completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                            break
                        }
                        
                    }
                    
                }
                
            case .failure(let error):
                debugPrint(#function, Self.self, "Failure: ", "with error", error)
                completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                break
                
            }
            
        }
        
    }
    
    // Language
    func apiGetAndSaveLanguages(withSyncItem item: MDSync.Item, completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) {
        
        debugPrint(#function, Self.self, "Start")
        
        let storageServiceType: MDStorageServiceType = .language
        var countResult: Int = .zero
        
        self.apiLanguage.getLanguages(accessToken: item.accessToken) { [unowned self] languagesResult in
            
            switch languagesResult {
                
            case .success(let languages):
                
                languageStorage.createLanguages(storageType: .all,
                                                languageEntities: languages) { createLanguagesResults in
                    
                    createLanguagesResults.forEach { createLanguagesResult in
                        
                        switch createLanguagesResult.result {
                            
                        case .success:
                            
                            countResult += 1
                            
                            if (countResult == createLanguagesResults.count) {
                                debugPrint(#function, Self.self, "Success")
                                completionHandler(.init(storageServiceType: storageServiceType, result: .success(())))
                                break
                            }
                            
                        case .failure(let error):
                            debugPrint(#function, Self.self, "Failure: ", "with error", error)
                            completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                            break
                        }
                        
                    }
                    
                }
                
            case .failure(let error):
                debugPrint(#function, Self.self, "Failure: ", "with error", error)
                completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                break
            }
            
        }
        
    }
    
    // Course
    func apiGetAndSaveCourses(withSyncItem item: MDSync.Item, completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) {
        
        debugPrint(#function, Self.self, "Start")
        
        let storageServiceType: MDStorageServiceType = .course
        var countResult: Int = .zero
        
        self.apiCourse.getCourses(accessToken: item.accessToken, byUserId: item.userId) { [unowned self] coursesResult in
            
            switch coursesResult {
                
            case .success(let courses):
                
                courseStorage.createCourses(storageType: .all, courseEntities: courses) { createCoursesResults in
                    
                    createCoursesResults.forEach { createCoursesResult in
                        
                        switch createCoursesResult.result {
                            
                        case .success:
                            
                            countResult += 1
                            
                            if (countResult == createCoursesResults.count) {
                                debugPrint(#function, Self.self, "Success")
                                completionHandler(.init(storageServiceType: storageServiceType, result: .success(())))
                                break
                            }
                            
                        case .failure(let error):
                            debugPrint(#function, Self.self, "Failure: ", "with error", error)
                            completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                            break
                        }
                        
                    }
                    
                }
                
            case .failure(let error):
                debugPrint(#function, Self.self, "Failure: ", "with error", error)
                completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                break
            }
            
        }
        
    }
    
    // Word
    func apiGetAndSaveWords(withSyncItem item: MDSync.Item, completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) {
        
        debugPrint(#function, Self.self, "Start")
        
        let storageServiceType: MDStorageServiceType = .word
        var countResult: Int = .zero
        
        self.apiWord.getWords(accessToken: item.accessToken, byUserId: item.userId) { [unowned self] wordsResult in
            
            switch wordsResult {
                
            case .success(let words):
                
                wordStorage.createWords(words, storageType: .all) { createWordsResults in
                    
                    createWordsResults.forEach { createWordsResult in
                        
                        switch createWordsResult.result {
                            
                        case .success:
                            
                            countResult += 1
                            
                            if (countResult == createWordsResults.count) {
                                debugPrint(#function, Self.self, "Success")
                                completionHandler(.init(storageServiceType: storageServiceType, result: .success(())))
                                break
                            }
                            
                        case .failure(let error):
                            debugPrint(#function, Self.self, "Failure: ", "with error", error)
                            completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                            break
                        }
                        
                    }
                    
                }
                
            case .failure(let error):
                debugPrint(#function, Self.self, "Failure: ", "with error", error)
                completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                break
            }
            
        }
        
    }
    
}
