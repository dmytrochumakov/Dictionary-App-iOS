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
                                        completionHandler: @escaping(([MDStorageServiceOperationResult]) -> Void)) {
        
        storageCleanupService.clearAllStorages { [unowned self] clearAllStoragesResults in
            
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
                                  progressCompletionHandler: progressCompletionHandler,
                                  completionHandler: completionHandler)
        
    }
    
}

fileprivate extension MDSync {
    
    func startFullSync(withSyncItem item: MDSync.Item,
                       progressCompletionHandler: @escaping((Float) -> Void),
                       completionHandler: @escaping(([MDStorageServiceOperationResult]) -> Void)) {
        
        // Initialize Sync Results
        var syncResults: [MDStorageServiceOperationResult] = []
        
        // Initialize Dispatch Group
        let dispatchGroup: DispatchGroup = .init()
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Get API And Save JWT
        apiGetAndSaveJWT(withSyncItem: item) { [unowned self] result in
            // Append Sync Result
            syncResults.append(result)
            // Compute And Pass Progress
            progressCompletionHandler(computeProgressForFullSync(finishedOperationsCount: syncResults.count))
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Get API And Save User
        apiGetAndSaveUser(withSyncItem: item) { [unowned self] result in
            // Append Sync Result
            syncResults.append(result)
            // Compute And Pass Progress
            progressCompletionHandler(computeProgressForFullSync(finishedOperationsCount: syncResults.count))
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Get API And Save Languages
        apiGetAndSaveLanguages(withSyncItem: item) { [unowned self] result in
            // Append Sync Result
            syncResults.append(result)
            // Compute And Pass Progress
            progressCompletionHandler(computeProgressForFullSync(finishedOperationsCount: syncResults.count))
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Get API And Save Courses
        apiGetAndSaveCourses(withSyncItem: item) { [unowned self] result in
            // Append Sync Result
            syncResults.append(result)
            // Compute And Pass Progress
            progressCompletionHandler(computeProgressForFullSync(finishedOperationsCount: syncResults.count))
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Get API And Save Words
        apiGetAndSaveWords(withSyncItem: item) { [unowned self] result in
            // Append Sync Result
            syncResults.append(result)
            // Compute And Pass Progress
            progressCompletionHandler(computeProgressForFullSync(finishedOperationsCount: syncResults.count))
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Notify And Pass Final Result
        dispatchGroup.notify(queue: .main) {
            completionHandler(syncResults)
        }
        
    }
    
    func jwtAndUserAndLanguageSync(withSyncItem item: Item,
                                   progressCompletionHandler: @escaping((Float) -> Void),
                                   completionHandler: @escaping (([MDStorageServiceOperationResult]) -> Void)) {
        
        // Initialize Sync Results
        var syncResults: [MDStorageServiceOperationResult] = []
        
        // Initialize Dispatch Group
        let dispatchGroup: DispatchGroup = .init()
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Get API And Save JWT
        apiGetAndSaveJWT(withSyncItem: item) { [unowned self] result in
            // Append Sync Result
            syncResults.append(result)
            // Compute And Pass Progress
            progressCompletionHandler(computeProgressForJWTAndUserAndLanguageSync(finishedOperationsCount: syncResults.count))
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Get API And Save User
        apiGetAndSaveUser(withSyncItem: item) { [unowned self] result in
            // Append Sync Result
            syncResults.append(result)
            // Compute And Pass Progress
            progressCompletionHandler(computeProgressForJWTAndUserAndLanguageSync(finishedOperationsCount: syncResults.count))
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Get API And Save Languages
        apiGetAndSaveLanguages(withSyncItem: item) { [unowned self] result in
            // Append Sync Result
            syncResults.append(result)
            // Compute And Pass Progress
            progressCompletionHandler(computeProgressForJWTAndUserAndLanguageSync(finishedOperationsCount: syncResults.count))
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Notify And Pass Final Result
        dispatchGroup.notify(queue: .main) {
            completionHandler(syncResults)
        }
        
    }
    
    func computeProgressForFullSync(finishedOperationsCount: Int) -> Float {
        return Float(finishedOperationsCount) / Float(MDStorageServiceType.allCases.count)
    }
    
    func computeProgressForJWTAndUserAndLanguageSync(finishedOperationsCount: Int) -> Float {
        return Float(finishedOperationsCount) / Float(3)
    }
    
}

// MARK: - API
fileprivate extension MDSync {
    
    // JWT
    func apiGetAndSaveJWT(withSyncItem item: MDSync.Item, completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) {
        
        let storageServiceType: MDStorageServiceType = .jwt
        var countResult: Int = .zero
        
        apiJWT.accessToken(jwtApiRequest: .init(nickname: item.nickname,
                                                password: item.password,
                                                userId: item.userId)) { [unowned self] jwtResult in
            
            switch jwtResult {
                
            case .success(let jwt):
                
                jwtStorage.createJWT(storageType: .all,
                                     jwtResponse: jwt) { createJWTResults in
                    
                    createJWTResults.forEach { createJWTResult in
                        
                        switch createJWTResult.result {
                            
                        case .success:
                            
                            countResult += 1
                            
                            if (countResult == createJWTResults.count) {
                                completionHandler(.init(storageServiceType: storageServiceType, result: .success(())))
                                break
                            }
                            
                        case .failure(let error):
                            completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                            break
                        }
                        
                    }
                    
                }
                
            case .failure(let error):
                completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                break
                
            }
            
        }
        
    }
    
    // User
    func apiGetAndSaveUser(withSyncItem item: MDSync.Item, completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) {
        
        let storageServiceType: MDStorageServiceType = .user
        var countResult: Int = .zero
        
        apiUser.getUser(accessToken: item.accessToken,
                        byUserId: item.userId) { [unowned self] userResult in
            
            switch userResult {
                
            case .success(let user):
                
                userStorage.createUser(user,
                                       password: item.password,
                                       storageType: .all) { createUserResults in
                    
                    createUserResults.forEach { createUserResult in
                        
                        switch createUserResult.result {
                            
                        case .success:
                            
                            countResult += 1
                            
                            if (countResult == createUserResults.count) {
                                completionHandler(.init(storageServiceType: storageServiceType, result: .success(())))
                                break
                            }
                            
                        case .failure(let error):
                            completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                            break
                        }
                        
                    }
                    
                }
                
            case .failure(let error):
                completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                break
                
            }
            
        }
        
    }
    
    // Language
    func apiGetAndSaveLanguages(withSyncItem item: MDSync.Item, completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) {
        
        let storageServiceType: MDStorageServiceType = .language
        var countResult: Int = .zero
        
        apiLanguage.getLanguages(accessToken: item.accessToken) { [unowned self] languagesResult in
            
            switch languagesResult {
                
            case .success(let languages):
                
                languageStorage.createLanguages(storageType: .all,
                                                languageEntities: languages) { createLanguagesResults in
                    
                    createLanguagesResults.forEach { createLanguagesResult in
                        
                        switch createLanguagesResult.result {
                            
                        case .success:
                            
                            countResult += 1
                            
                            if (countResult == createLanguagesResults.count) {
                                completionHandler(.init(storageServiceType: storageServiceType, result: .success(())))
                                break
                            }
                            
                        case .failure(let error):
                            completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                            break
                        }
                        
                    }
                    
                }
                
            case .failure(let error):
                completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                break
            }
            
        }
        
    }
    
    // Course
    func apiGetAndSaveCourses(withSyncItem item: MDSync.Item, completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) {
        
        let storageServiceType: MDStorageServiceType = .course
        var countResult: Int = .zero
        
        apiCourse.getCourses(accessToken: item.accessToken, byUserId: item.userId) { [unowned self] coursesResult in
            
            switch coursesResult {
                
            case .success(let courses):
                
                courseStorage.createCourses(storageType: .all, courseEntities: courses) { createCoursesResults in
                    
                    createCoursesResults.forEach { createCoursesResult in
                        
                        switch createCoursesResult.result {
                            
                        case .success:
                            
                            countResult += 1
                            
                            if (countResult == createCoursesResults.count) {
                                completionHandler(.init(storageServiceType: storageServiceType, result: .success(())))
                                break
                            }
                            
                        case .failure(let error):
                            completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                            break
                        }
                        
                    }
                    
                }
                
            case .failure(let error):
                completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                break
            }
            
        }
        
    }
    
    // Word
    func apiGetAndSaveWords(withSyncItem item: MDSync.Item, completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) {
        
        let storageServiceType: MDStorageServiceType = .word
        var countResult: Int = .zero
        
        apiWord.getWords(accessToken: item.accessToken, byUserId: item.userId) { [unowned self] wordsResult in
            
            switch wordsResult {
                
            case .success(let words):
                
                wordStorage.createWords(words, storageType: .all) { createWordsResults in
                    
                    createWordsResults.forEach { createWordsResult in
                        
                        switch createWordsResult.result {
                            
                        case .success:
                            
                            countResult += 1
                            
                            if (countResult == createWordsResults.count) {
                                completionHandler(.init(storageServiceType: storageServiceType, result: .success(())))
                                break
                            }
                            
                        case .failure(let error):
                            completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                            break
                        }
                        
                    }
                    
                }
                
            case .failure(let error):
                completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                break
            }
            
        }
        
    }
    
}
